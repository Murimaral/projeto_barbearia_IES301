class RescueRequest < ApplicationRecord
  validates :owner_id, :rescuer_id, :message, :status, presence: true
  validate :acceptable_image

  enum status: { open: 0, accepted: 1, refused: 2, cancelled: 3 }
  has_one_attached :image

  def found_pet
    Pet.find(found_pet_id) if found_pet_id
  end

  def lost_pet
    Pet.find(lost_pet_id) if lost_pet_id
  end

  def owner
    User.find(owner_id)
  end

  def rescuer
    User.find(rescuer_id)
  end

  def acceptable_image
    return unless image.attached?

    errors.add(:image, 'is too big') unless image.byte_size <= 1.megabyte

    acceptable_types = ['image/jpeg', 'image/png']

    errors.add(:image, 'must be a JPEG or PNG') unless acceptable_types.include?(image.content_type)
  end
end
