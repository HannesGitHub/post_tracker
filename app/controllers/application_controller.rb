class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :current_user,
                :user_configurations

  SALT_VAL = '$2a$10$LH.HAI7A6kAVfrXlIUc9Ee'
  USER_CONFIGURATIONS = ['first_notification_to_recipient', 'all_updates']

  def redirect_unauthorized
    flash[:unauthorized] = true
    redirect_to '/sign_in'
  end

  def current_user
    token = cookies.permanent[:remember_token]
    encrypted_token = BCrypt::Engine.hash_secret(token, SALT_VAL)
    @current_user ||= User.find_by(remember_token: encrypted_token) if cookies[:remember_token]
  end

  def user_configurations
    USER_CONFIGURATIONS
  end
end
