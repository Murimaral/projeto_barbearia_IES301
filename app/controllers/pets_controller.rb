class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    if @pet.save
      redirect_to @pet
    else
      flash[:alert] = 'Não foi possível registrar o pet'
      render :new
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      redirect_to @pet
    else
      flash[:alert] = 'Erro na edição'
    end
  end

  private

  def pet_params
    params.require(:pet).permit(:name, :species, :sex, :breed, :color, :image, :details, :city, :state, :status,
                                :active)
  end
end
