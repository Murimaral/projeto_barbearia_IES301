class Attendance < ApplicationRecord
  belongs_to :customer
  belongs_to :employee
  belongs_to :service

  validate :employee_availability

  def employee_availability
    attendances = Attendance.
      where(employee_id: employee_id).
      where('start_date BETWEEN ? and ?', start_date, end_date).
      where('end_date BETWEEN ? and ?', start_date, end_date)

    unless attendances.blank?
      errors.add(:base, 'Funcionário já possui agendamento nesse horário')
    end
  end
end
