class Admin::BaseAdminController < ApplicationController
  layout 'admin_layout'
  before_action :check_authorization

  SALT_VAL = '$2a$10$LH.HAI7A6kAVfrXlIUc9Ee'

  private

  def check_authorization
    token = cookies.permanent[:remember_token]
    encrypted_token = BCrypt::Engine.hash_secret(token, SALT_VAL)
    @user = User.find_by(remember_token: encrypted_token)
    if !@user
    #   User was not valid from cookie, redirect
      flash[:unauthorized] = true
      redirect_to '/sign_in'
    end
  end

end