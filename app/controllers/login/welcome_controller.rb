class Login::WelcomeController < ApplicationController
  def landing

  end

  def sign_up
    @user = User.new
    render layout: false
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

  end

  private
  def user_params
    params.require(:user).permit(:name, :surname, :username)
  end
end
