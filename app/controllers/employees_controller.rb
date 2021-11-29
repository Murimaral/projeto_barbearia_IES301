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

  private

  def set_employee
    @employee ||= Employee.find(params[:id])
  end

  def employee_params
    params.require(:employee).permit!
  end
end
# rubocop: enable Metrics/ClassLength

