class Login::WelcomeController < ApplicationController

  def landing

  end

  def sign_up
    @user = User.new
    render layout: false
  end

  def sign_in
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
        @user.save
        if @user.is_admin?
          redirect_to '/admin/users'
        else
          redirect_to '/users'
        end
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

  def confirm_account
    user = User.find_by(account_activation_token: params[:token])
    # Todo: Add check to see if the time has expired and the user cannot activate their account anymore. Have a look at the account_activation_token_expiration_date field in the db.
    # Todo: Make sure that the someone cannot just navigate to this path with empty param :token and still authorize a user.
    user.is_signup_request = false
    user.account_activation_token = nil
    user.save

    redirect_to confirmation_successful_url(id: user.id)
  end

  def confirmation_successful
    @user = User.find(params[:id])
    render layout: false
  end

  def set_password
    @user = User.find(user_password_confirm_params[:id])
    if user_password_confirm_params[:password] == user_password_confirm_params[:confirm_password]
      @user.password = user_password_confirm_params[:password]
      @user.save
      redirect_to sign_in_url
    else
      #   Passwords doesn't match
      flash[:passwords_no_match] = true
      render 'confirmation_successful', layout: false
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
  end

  def user_params
    params.require(:user).permit(:id, :name, :password, :surname, :email, :remember_token)
  end

  def user_password_confirm_params
    params.require(:user).permit(:id, :password, :confirm_password)
  end

end
