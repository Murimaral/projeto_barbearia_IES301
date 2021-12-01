class Service < ApplicationRecord
  has_and_belongs_to_many :employees

  validates :name, presence: true
end
