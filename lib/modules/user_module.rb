module UserModule

  def generate_email_token
    token = ""
    loop do
      token = SecureRandom.hex(10)
      break token unless User.where(account_activation_token: token).exists?
    end
    self.account_activation_token = token
    self.account_activation_token_generation_date = Time.now
    self.save
  end


end