class User < ApplicationRecord

  include UserModule
  include EmailModule

  before_create :generate_auth_token, :generate_configuration

  has_many :trackings
  has_one :configuration

  attr_accessor :confirm_password
  scope :active_scope, -> { where(is_active: true).where.not(email: 'admin@gmail.com') }

  # Make sure what this validations does otherwise remove it
  has_secure_password validations: false

  validates :name,
            :surname,
            :email,
            presence: true

  def name_and_surname
    "#{self.name} #{self.surname}"
  end

  private
  def generate_auth_token
    if !self.is_signup_request

      begin
        self.auth_token = SecureRandom.hex
      end while self.class.exists?(auth_token: auth_token)
    end
  end

  def generate_configuration
    self.configuration = Configuration.new()
  end
end