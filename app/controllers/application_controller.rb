class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def redirect_unauthorized
    flash[:unauthorized] = true
    redirect_to '/sign_in'
  end
end
