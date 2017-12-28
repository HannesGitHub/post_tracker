class Admin::AdminUsersController < Admin::BaseAdminController
  def index
    @users = User.all.active
  end
end