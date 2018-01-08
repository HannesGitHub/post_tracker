class Login::WelcomeController < ApplicationController

  SALT_VAL = '$2a$10$LH.HAI7A6kAVfrXlIUc9Ee'

  def landing

  end

  def sign_up
    @user = User.new
    render layout: false
  end

  def sign_in
    if flash[:unauthorized]
      @invalid = true
    end

    @user = User.new
    render layout: false
  end

  def authenticate
    @user = User.find_by(email: user_params[:email]).try(:authenticate, user_params[:password])
    if @user
      # Authenticated
      token = set_cookie_and_return_token
      if user_params[:remember_token]
      #   remember me was ticked
        @user.remember_token = encrypt_token(token)
        @user.remember_token = ""
        @user.save
        redirect_to '/admin/users'
      else
      #   Do not remember user, also do not do anything.
      end
    else
    #   Unauthorized
    #   Todo: redirect to another invalid page or same page with message ect...
      flash[:invalid_details] = true
      redirect_to action: :sign_in
    end
  end

  def request_signup
    @user = User.new(user_params)
    @user.is_signup_request = true #Flag user as signup request
    if @user.save
      # Saves successfully
      redirect_to action: :signup_successfull_and_pending
    else
      # Error saving user
      render 'sign_up', layout: false
    end
  end

  def signup_successfull_and_pending
    render layout: false
  end

  private

  # Todo: Move this to a module and include the module in the user model.
  def set_cookie_and_return_token
    token = generate_token
    cookies.permanent[:remember_token] = token
    token
  end

  def generate_token
    token = Array.new(16) { rand(256) }.pack('C*').unpack('H*').first
  end

  def encrypt_token(token)

     BCrypt::Engine.hash_secret(token, SALT_VAL)


    # key   = ActiveSupport::KeyGenerator.new('password').generate_key(token, 32) # => "\x89\xE0\x156\xAC..."
    # crypt = ActiveSupport::MessageEncryptor.new(key)                           # => #<ActiveSupport::MessageEncryptor ...>
    # encrypted_data = crypt.encrypt_and_sign('my secret data')                  # => "NlFBTTMwOUV5UlA1QlNEN2xkY2d6eThYWWh..."
  end

  def user_params
    params.require(:user).permit(:name, :surname, :email, :password, :remember_token)
  end

end
