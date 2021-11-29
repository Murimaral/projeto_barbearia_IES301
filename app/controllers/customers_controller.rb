# rubocop: disable Metrics/ClassLength
class CustomersController < ApplicationController
  before_action :set_customer, only: %i[edit show update]
  skip_before_action :verify_authenticity_token, only: :search

  def new
    flash[:alert] = ''
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    if @customer.save
      redirect_to @customer
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
    if @customer.update(customer_params)
      redirect_to @customer
    else
      flash[:alert] = 'Não foi possível salvar. Verifique todos os campos!'
      render :edit
    end
  end

  def search
    render json: find_customer, status: :ok
  end

  private

  def find_customer
    [:name, :phone, :details, :email].map do |attr|
      Customer.where("#{attr} ILIKE ?", "%#{params[:name]}%")
    end.flatten.uniq
  end

  def set_customer
    @customer ||= Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit!
  end
end
# rubocop: enable Metrics/ClassLength

