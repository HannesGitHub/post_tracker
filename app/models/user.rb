class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  before_create :generate_auth_token



  validates :name,
            :surname,
            :email,
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
