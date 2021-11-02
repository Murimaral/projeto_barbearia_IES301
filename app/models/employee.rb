class Employee < ApplicationRecord
  validates :name, :phone, :document, presence: true

  enum gender: { male: 0, female: 1, other: 2 }
  enum status: { active: 0, vacation: 1, deactivated: 2 }

  scope :by_gender, ->(param) { where(gender: param) }
end
