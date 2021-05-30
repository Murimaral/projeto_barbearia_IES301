class RescueRequest < ApplicationRecord
  validates :owner_id, :rescuer_id, :message, :status, presence: true
  enum status: { open: 0, accepted: 1, refused: 2, cancelled: 3 }

  def found_pet
    Pet.find(found_pet_id)
  end

  def lost_pet
    Pet.find(lost_pet_id)
  end

  def owner
    User.find(owner_id)
  end

  def rescuer
    User.find(rescuer_id)
  end
end
