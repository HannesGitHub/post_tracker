class Admin::BaseAdminController < ApplicationController
  layout 'admin_layout'
  before_action :check_authorization

  private

  def check_authorization
    token = cookies.permanent[:remember_token]
    encrypted_token = BCrypt::Engine.hash_secret(token, SALT_VAL)
    @user = User.find_by(remember_token: encrypted_token)
    if !@user
    #   User was not valid from cookie, redirect
      redirect_unauthorized
    else
      if !@user.is_admin?
        redirect_unauthorized
      else
        # Sets the cookie to be able to use it throughout the system.
        cookies[:active_user_id] = @user.id
      end
    end
  end

end