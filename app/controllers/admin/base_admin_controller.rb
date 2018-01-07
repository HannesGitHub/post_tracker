class Admin::BaseAdminController < ApplicationController
  layout 'admin_layout'
  before_action :check_authorization

  SALT_VAL = '$2a$10$LH.HAI7A6kAVfrXlIUc9Ee'

  private

  def check_authorization
    token = cookies.permanent[:remember_token]
    encrypted_token = BCrypt::Engine.hash_secret(token, SALT_VAL)
    @user = User.find_by(remember_token: encrypted_token)
    if @user
    #   User valid from cookie
      test = 3
    else
    # User not valid from cookie
      test = 3
    end
  end

end