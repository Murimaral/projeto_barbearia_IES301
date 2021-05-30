class RescueRequestsController < ApplicationController
  before_action :authenticate_user!

  def new
    @rescue_params = params.permit(:found_pet_id, :lost_pet_id)
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

  def answer
    @rescue_request = RescueRequest.find(params[:rescue_request_id])
  end

  def update
    @rescue_request = RescueRequest.find(params[:id])
    @rescue_params = rescue_params
    if @rescue_request.update(@rescue_params)
      update_pets
      redirect_to @rescue_request
    else
      flash[:alert] = 'Erro na edição'
      render :edit
    end
  end
  private

  def rescue_params
    params.require(:rescue_request).permit(:found_pet_id, :lost_pet_id, :owner_id, :rescuer_id, :created_by_owner,
                                           :image, :message, :status, :reply)
  end

  def user_claims_ownership?
    @rescue_params[:found_pet_id].present?
  end

  def load_data
    if @user_claims_ownership
      @found_pet = Pet.find(@rescue_params[:found_pet_id])
      @my_pets = current_user.pets.where(active: true).where(status: :lost).where(species: @found_pet.species)
    else
      @lost_pet = Pet.find(@rescue_params[:lost_pet_id])
      @my_pets = current_user.pets.where(active: true).where(status: :found).where(species: @lost_pet.species)
    end
  end

  def update_pets
    return unless @rescue_params[:status] == 'accepted'

    @rescue_request.found_pet.update(active: false) if @rescue_request.found_pet_id.present?
    @rescue_request.lost_pet.update(active: false) if @rescue_request.lost_pet_id.present?
  end
end
