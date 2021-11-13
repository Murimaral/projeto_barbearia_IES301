class Attendance < ApplicationRecord
  belongs_to :customer
  belongs_to :employee
  belongs_to :service
end
