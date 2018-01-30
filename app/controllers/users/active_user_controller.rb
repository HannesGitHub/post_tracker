class Users::ActiveUserController < Users::BaseUsersController

  def update_user_settings
    # redirect_back(root_path)
    current_user.configuration.notification_setting = configuration_params[:configuration]
    current_user.save and return
  end

  private
  def configuration_params
    params.require(:user).permit(:configuration)
  end

end