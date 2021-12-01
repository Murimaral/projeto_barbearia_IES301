class Attendance < ApplicationRecord
  belongs_to :customer
  belongs_to :employee
  belongs_to :service

  validate :employee_availability
  validate :end_after_start
  validate :employee_has_service

  def employee_availability
    attendances = Attendance.
      where(employee_id: employee_id).
      where('start_date BETWEEN ? and ?', start_date, end_date).
      where('end_date BETWEEN ? and ?', start_date, end_date)

    unless attendances.blank?
      errors.add(:base, 'Funcionário já possui agendamento nesse horário')
    end
  end

  def end_after_start
    if start_date >= end_date
      errors.add(:base, 'Horário de término tem que ser maior que o de início')
    end
  end

  def employee_has_service
    service_ids = Employee.find(employee_id).services.map(&:id)

    unless service_ids.include?(service_id)
      errors.add(:base, 'Este funcionário não presta este serviço')
    end
  end
end
