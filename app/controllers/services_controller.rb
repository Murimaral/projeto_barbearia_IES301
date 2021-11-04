# rubocop: disable Metrics/ClassLength
class ServicesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show search searchpage]
  before_action :set_service, only: %i[edit show update]
  skip_before_action :verify_authenticity_token, only: :search

  def index
    @services = Services.where(active: true).order('created_at DESC')
  end

  def new
    flash[:alert] = ''
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)

    if @service.save
      redirect_to @service
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
    if @service.update(service_params)
      redirect_to @service
    else
      flash[:alert] = 'Não foi possível salvar. Verifique todos os campos!'
      render :edit
    end
  end

  private

  def set_service
    @service ||= Service.find(params[:id])
  end

  def service_params
    params.require(:service).permit!
  end
end
