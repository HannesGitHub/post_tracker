class User < ApplicationRecord
  validates :name,
            :surname,
            :username,
            :password,
            presence: true

  scope :active, -> { where(is_active: true) }
end
