module Authenticateble
  # Todo: Fix this class, this is not being used but should be used in welcome controller.

  def self.remember_me
    test = 3
  end

  def generate_token
    SecureRandom.urlsafe_base64(nil, false)
  end

  def encrypt_token(token)
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
    encrypted_data = crypt.encrypt_and_sign(token)
  end

  def generate_remember_token_and_save_to_cookie

    @user.remember_token = @user.new_remember_token
  end

end