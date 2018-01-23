class Users::BaseUsersController < ApplicationController
  layout 'application'
  before_action :check_authorization,
                :load_track_more_api_connection

  attr_accessor :track_more_api

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
    else
      # Sets the cookie to be able to use it throughout the system.
      cookies[:active_user_id] = @user.id
    end
  end

  def load_track_more_api_connection
    self.track_more_api = TrackMoreCommunication.new()
  end

end