class User < ApplicationRecord

  before_create :generate_auth_token

  has_secure_password

  validates :name,
            :surname,
            :username,
            :password,
            presence: true

  scope :active, -> { where(is_active: true) }

  private
  def generate_auth_token
    begin
      self.auth_token = SecureRandom.hex
    end while self.class.exists?(auth_token: auth_token)
  end
end
