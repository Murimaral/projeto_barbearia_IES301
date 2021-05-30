class Pet < ApplicationRecord
  validates :species, :sex, :breed, :color, :city, :state, :status, presence: true
  validate :acceptable_image

  belongs_to :user
  has_one_attached :image

  enum species: { cat: 0, dog: 1 }
  enum sex: { female: 0, male: 1 }
  enum status: { found: 0, lost: 1 }

  scope :by_species, ->(param) { where(species: param) }
  scope :by_sex, ->(param) { where(sex: param) }
  scope :by_status, ->(param) { where(status: param) }
  scope :by_active, ->(param) { where(active: param) }

  scope :by_name, ->(param) { where('name ILIKE ?', "%#{param}%") }
  scope :by_breed, ->(param) { where('breed ILIKE ?', "%#{param}%") }
  scope :by_color, ->(param) { where('color ILIKE ?', "%#{param}%") }
  scope :by_city, ->(param) { where('city ILIKE ?', "%#{param}%") }
  scope :by_state, ->(param) { where('state ILIKE ?', "%#{param}%") }

  def acceptable_image
    return unless image.attached?

    errors.add(:image, 'is too big') unless image.byte_size <= 1.megabyte

    acceptable_types = ['image/jpeg', 'image/png']

    errors.add(:image, 'must be a JPEG or PNG') unless acceptable_types.include?(image.content_type)
  end
end
