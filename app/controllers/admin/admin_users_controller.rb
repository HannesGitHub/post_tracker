class Admin::AdminUsersController < Admin::BaseAdminController
  def index
    @users = User.all.active
  end

  def test
    render 'show'
  end
  def new
    @description = 'Add user'
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
    # Saves successfully
      redirect_to action: :index
    else
    # Error saving user
    render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def approve
    user = User.find(params[:id])
    user.generate_email_token
    user.email_token_to_user

  end

  private
  def user_params
    params.require(:user).permit(:name, :surname, :email, :password)
  end
end