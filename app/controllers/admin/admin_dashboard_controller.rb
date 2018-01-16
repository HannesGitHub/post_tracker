class Admin::AdminDashboardController < Admin::BaseAdminController
  def index
    puts "**************************************#{Figaro.env.email_server_user_name}***********************************"
    asdf = 3
    asdfa = 3
  end
end