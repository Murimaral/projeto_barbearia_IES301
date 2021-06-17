class RescueRequest < ApplicationRecord
  validates :owner_id, :rescuer_id, :message, :status, presence: true
  validate :acceptable_image

  enum status: { open: 0, accepted: 1, refused: 2, cancelled: 3 }
  has_one_attached :image

  belongs_to :owner, class_name: 'User'
  belongs_to :rescuer, class_name: 'User'
  belongs_to :found_pet, class_name: 'Pet', optional: true
  belongs_to :lost_pet, class_name: 'Pet', optional: true

  def acceptable_image
    return unless image.attached?

    errors.add(:image, 'is too big') unless image.byte_size <= 1.megabyte

    acceptable_types = ['image/jpeg', 'image/png']

    errors.add(:image, 'must be a JPEG or PNG') unless acceptable_types.include?(image.content_type)
  end
end
