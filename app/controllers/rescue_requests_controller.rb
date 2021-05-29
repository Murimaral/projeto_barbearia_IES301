class RescueRequestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @rescue_params = params.permit(:found_pet_id)
    @found_pet = Pet.find(@rescue_params[:found_pet_id])
    @user_claims_ownership = user_claims_ownership?
    load_data
    @rescue_request = RescueRequest.new
  end

  def create
    @rescue_params = rescue_params
    @rescue_request = RescueRequest.new(@rescue_params)
    if @rescue_request.save
      redirect_to @rescue_request
    else
      flash[:alert] = 'Não foi possível criar o pedido de resgate'
      render :new
    end
  end

  def show
    @rescue_request = RescueRequest.find(params[:id])
  end

  private

  def rescue_params
    params.require(:rescue_request).permit(:found_pet_id, :lost_pet_id, :owner_id, :rescuer_id, :created_by_owner, :image, :message)
  end

  def user_claims_ownership?
    @found_pet.user != current_user
  end

  def load_data
    @my_pets = current_user.pets.where(active: true).where(status: :lost) if user_claims_ownership?
  end
end