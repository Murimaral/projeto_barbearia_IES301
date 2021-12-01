class Employee < ApplicationRecord
  has_and_belongs_to_many :services

  validates :name, :phone, :document, presence: true

  enum gender: { male: 0, female: 1, other: 2 }
  enum status: { active: 0, vacation: 1, deactivated: 2 }

  scope :by_gender, ->(param) { where(gender: param) }

  validate :employee_has_service

  def employee_has_service
    if self.services.blank?
      errors.add(:base, 'É necessário adicionar pelo menos um serviço')
    end
  end
end
