class PetsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :find_pet, only: %i[show edit update]
  before_action :find_author, only: %i[show edit update]
  before_action :check_ownership, only: %i[edit update]

  def index
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user_id = current_user.id
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
    end
  end

  private

  def find_pet
    @pet = Pet.find(params[:id])
  end

  def find_author
    @author = User.find(@pet.user_id)
  end

  def check_ownership
    redirect_to :root unless @author.id == current_user.id
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :sex, :breed, :color, :image, :details, :city, :state, :status,
                                :active)
  end
end
