class AttendancesController < ApplicationController
  before_action :set_attendance, only: %i[ show edit update destroy ]

  # GET /attendances or /attendances.json
  def index
    @attendances = Attendance.all
  end

  # GET /attendances/1 or /attendances/1.json
  def show
  end

  # GET /attendances/new
  def new
    flash[:alert] = ''
    @attendance = Attendance.new
    @services = Service.all
    @employees = Employee.active.all
    @customer_id = params[:customer_id]

    date_params = params[:date] || DateTime.now.to_s
    @date = Time.parse(date_params)
  end

  # GET /attendances/1/edit
  def edit
    flash[:alert] = ''
    @services = Service.all
    @employees = Employee.active.all
  end

  # POST /attendances or /attendances.json
  def create
    start_at = DateTime.parse("#{attendance_params[:day]} #{attendance_params[:start_at]} utc-3")
    end_at = DateTime.parse("#{attendance_params[:day]} #{attendance_params[:end_at]} utc-3")

    @attendance = Attendance.new({
      title: attendance_params[:title],
      description: attendance_params[:description],
      start_date: start_at,
      end_date: end_at,
      customer_id: attendance_params[:customer_id],
      employee_id: attendance_params[:employee_id],
      service_id: attendance_params[:service_id]
    })

    respond_to do |format|
      if @attendance.save
        format.html { redirect_to @attendance, notice: "Attendance was successfully created." }
        format.json { render :show, status: :created, location: @attendance }
      else
        flash[:alert] = 'Atendimento não pode ser salvo, horário indisponível'
        @services = Service.all
        @employees = Employee.all
        @customer_id = params[:customer_id]

        date_params = start_at.to_s || DateTime.now.to_s
        @date = Time.parse(date_params)

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendances/1 or /attendances/1.json
  def update
    start_at = DateTime.parse("#{attendance_params[:day]} #{attendance_params[:start_at]} utc-3")
    end_at = DateTime.parse("#{attendance_params[:day]} #{attendance_params[:end_at]} utc-3")

    att = {
      title: attendance_params[:title],
      description: attendance_params[:description],
      start_date: start_at,
      end_date: end_at,
      customer_id: attendance_params[:customer_id],
      employee_id: attendance_params[:employee_id],
      service_id: attendance_params[:service_id]
    }

    @services = Service.all
    @employees = Employee.all

    respond_to do |format|
      if @attendance.update(att)
        format.html { redirect_to schedule_path }
        format.json { render :show, status: :ok, location: @attendance }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendances/1 or /attendances/1.json
  def destroy
    @attendance.destroy
    respond_to do |format|
      format.html { redirect_to attendances_url, notice: "Attendance was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def schedule
    @attendances = Attendance.all.map do |attendance|
      {
        id: attendance.id,
        title: attendance.title,
        start: attendance.start_date,
        end: attendance.end_date
      }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_attendance
    @attendance = Attendance.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def attendance_params
    params.require(:attendance).permit!
  end
end
