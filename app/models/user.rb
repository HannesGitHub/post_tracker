class User < ApplicationRecord

  before_create :generate_auth_token



  validates :name,
            :surname,
            :username,
            presence: true

  scope :active, -> { where(is_active: true) }

  private
  def generate_auth_token
    if !self.is_signup_request
      has_secure_password
      begin
        self.auth_token = SecureRandom.hex
      end while self.class.exists?(auth_token: auth_token)
    end
  end
end
