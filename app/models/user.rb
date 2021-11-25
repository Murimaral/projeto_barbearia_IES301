class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def destroy
    update(deactivated: true) unless deactivated
  end

  def active_for_authentication?
    super && !deactivated
  end
end
