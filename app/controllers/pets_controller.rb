class PetsController < ApplicationController
  before_action :authenticate_user!, except: %i[index show search]
  before_action :find_pet, only: %i[show edit update confirm_deactivation deactive]
  before_action :check_ownership, only: %i[edit update confirm_deactivation]
  skip_before_action :verify_authenticity_token, only: :search

  def index
    @pets = Pet.where(active: true).order('created_at DESC')
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

  def show; end

  def edit; end

  def update
    if @pet.update(pet_params)
      redirect_to @pet
    else
      flash[:alert] = 'Erro na edição'
      render :edit
    end
  end

  def confirm_deactivation; end

  def deactive
    @pet.update(active: false)
    redirect_to @pet
  end

  def search
    @search_params = search_params
    @pets = params[:exact] == 'true' ? exact_search : advanced_search

    render json: @pets, status: :ok
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

  def exact_search
    pets = Pet.order('created_at DESC')
    @search_params.each_key do |filter|
      search_results = pets.send("by_#{filter}", @search_params[filter])
      pets = search_results
    end
    check_visibility(pets)
  end

  def advanced_search
    pets = [*Pet.order('created_at DESC')]
    @search_params.each_key do |filter|
      search_results = Pet.send("by_#{filter}", @search_params[filter])
      pets.push(*search_results)
    end
    check_exact_params(pets).sort! { |a, b| pets.count(b) <=> pets.count(a) }
                            .uniq
  end

  def pet_params
    params.require(:pet).permit(:name, :species, :sex, :breed, :color, :image, :details, :city, :state, :status,
                                :active)
  end

  def search_params
    p = params.permit(:name, :species, :sex, :breed, :color, :city, :state, :status, :active)
    p.reject! { |_key, value| value.empty? }
  end

  def check_exact_params(array)
    array = array.select { |pet| pet[:species] == @search_params[:species] } if @search_params[:species].present?
    array = array.select { |pet| pet[:status] == @search_params[:status] } if @search_params[:status].present?
    check_visibility(array)
  end

  def check_visibility(array)
    return array.select { |pet| pet[:active] == true } unless params[:active] == 'false'

    array.select { |pet| pet[:active] == false }
  end
end
