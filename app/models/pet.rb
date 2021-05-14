class Pet < ApplicationRecord
  validates :species, :sex, :breed, :color, :city, :state, :status, presence: true

  enum species: { cat: 0, dog: 1 }
  enum sex: { female: 0, male: 1 }
  enum status: { found: 0, lost: 1 }
end