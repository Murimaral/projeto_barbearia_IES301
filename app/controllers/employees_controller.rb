# rubocop: disable Metrics/ClassLength
class EmployeesController < ApplicationController
  before_action :set_employee, only: %i[edit show update]
  skip_before_action :verify_authenticity_token, only: :search

  def index
    @employees = Employee.active.order('name ASC')
    @deactivated_employees = Employee.deactivated.order('name ASC')
    @vacation_employees = Employee.vacation.order('name ASC')
  end

  def new
    flash[:alert] = ''
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)

    @employee.services = params[:service_id] ? params[:service_id].map { |a| Service.find(a) } : []

    if @employee.save
      redirect_to @employee
    else
      custom_alert
      render :new
    end
  end

  def show
  end

  def edit
    @services = @employee.services.map(&:id) || []
    flash[:alert] = ''
  end

  def update
    @services = @employee.services.map(&:id) || []

    @employee.services = params[:service_id] ? params[:service_id].map { |a| Service.find(a) } : []

    if @employee.update(employee_params)
      redirect_to @employee
    else
      custom_alert
      render :edit
    end
  end

  private

  def custom_alert
    if @employee.errors[:base].blank?
      flash[:alert] = 'Não foi possível salvar. Verifique todos os campos!'
    else
      flash[:alert] = @employee.errors[:base].join(", ")
    end
  end

  def set_employee
    @employee ||= Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit!
  end
end
# rubocop: enable Metrics/ClassLength

