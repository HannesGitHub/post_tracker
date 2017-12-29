class Admin::AdminUsersController < Admin::BaseAdminController
  def index
    @users = User.all.active
  end

  def new
    @user = User.new
  end


end