# rubocop: disable Metrics/ClassLength
class EmployeesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show search searchpage]
  before_action :set_employee, only: %i[edit show update]
  skip_before_action :verify_authenticity_token, only: :search

  def index
    @pets = Pet.where(active: true).order('created_at DESC')
  end

  def new
    flash[:alert] = ''
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)

    if @employee.save
      redirect_to @employee
    else
      flash[:alert] = 'Não foi possível salvar. Verifique todos os campos!'
      render :new
    end
  end

  def show; end

  def edit
    flash[:alert] = ''
  end

  def update
    if @employee.update(employee_params)
      redirect_to @employee
    else
      flash[:alert] = 'Não foi possível salvar. Verifique todos os campos!'
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
    @results = []
    @pets.each do |pet|
      result = JSON.parse(pet.to_json)
      result[:image] = url_for(pet.image)
      @results << result
    end

    render json: @results, status: :ok
  end

  private

  def set_employee
    @employee ||= Employee.find(params[:id])
  end

  def find_pet
    @pet = Pet.find(params[:id] || params[:pet_id])
  end

  def check_ownership
    redirect_to root_path unless @pet.user == current_user || current_user.admin?
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

  def employee_params
    params.require(:employee).permit!
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
    result = array
    result = result.select { |pet| pet[:active] == true }
    if @search_params[:state].present?
      result = result.select do |pet|
        pet[:state].downcase.include?(@search_params[:state].downcase)
      end
    end

    result
  end

  def find_states
    @states = {}
    Locations::STATES.map { |state| @states[state[:name]] = nil }
  end

  def find_cities
    all_cities = []
    Locations::STATES.map { |state| all_cities.push(*state[:cities]) }
    all_cities.sort!
    @cities = {}
    all_cities.map { |city| @cities[city] = nil }
  end

  def find_breeds
    all_breeds = [*Breeds::DOG_BREEDS, *Breeds::CAT_BREEDS].sort
    @breeds = {}
    all_breeds.map { |breed| @breeds[breed] = nil }
  end
end
# rubocop: enable Metrics/ClassLength

