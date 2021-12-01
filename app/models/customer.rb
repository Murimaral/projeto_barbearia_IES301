class Customer < ApplicationRecord
  validates :name, :phone, presence: true

  validate :single_phone

  def single_phone
    if User.find_by(phone: phone)
      errors.add(:base, 'Já existe um cliente com este telefone')
    end
  end
end
