class Admin::AdminUsersController < Admin::BaseAdminController
  def index
    @users = User.active_scope
  end

  def new
    @description = 'Add user'
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
    # Saves successfully
      @user.generate_email_token
      @user.email_token_to_user
      redirect_to action: :index
    else
    # Error saving user
    render 'new'
    end
  end

  def edit
    @description = 'Edit user'
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(user_params[:id])
    if @user.update_attributes(user_params)
      redirect_to admin_users_url
    else
      @description = 'Edit user'
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def approve
    user = User.find(params[:id])
    user.generate_email_token
    user.email_token_to_user
    redirect_to "/admin/users/#{params[:id]}/show"
  end

  def delete
    user = User.find(params[:id])
    user.is_active = false
    user.save
    redirect_to admin_users_path
  end

  private
  def user_params
    params.require(:user).permit(:id, :name, :surname, :email, :password, :is_admin)
  end
end