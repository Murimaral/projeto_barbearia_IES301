class Attendance < ApplicationRecord
  has_one :customer, :employee, :service
end
