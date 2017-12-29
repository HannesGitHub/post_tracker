class Admin::AdminUsersController < Admin::BaseAdminController
  def index
    @users = User.all.active
  end

  def new
    @description = 'Add user'
    @user = User.new
  end

  def create
    test = 3
  end


end