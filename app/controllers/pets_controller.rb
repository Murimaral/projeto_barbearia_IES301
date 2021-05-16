class PetsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_pet, only: %i[show edit update confirm_deactivation deactive]
  before_action :check_ownership, only: %i[edit update confirm_deactivation]

  def index
    @pets = Pet.where(active: true).all
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.image = params[:image] || generate_avatar
    @pet.user = current_user
    if @pet.save
      redirect_to @pet
    else
      flash[:alert] = 'Não foi possível registrar o pet'
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @pet.update(pet_params)
      redirect_to @pet
    else
      flash[:alert] = 'Erro na edição'
      render :edit
    end
  end

  def confirm_deactivation
  end

  def deactive
    @pet.update(active: false)
    redirect_to @pet
  end

  private

  def find_pet
    @pet = Pet.find(params[:id] || params[:pet_id])
  end

  def check_ownership
    redirect_to root_path unless @pet.user == current_user
  end

  def generate_avatar
    Faker::Avatar.image(slug: params[:name])
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :sex, :breed, :color, :image, :details, :city, :state, :status,
                                :active)
  end
end
