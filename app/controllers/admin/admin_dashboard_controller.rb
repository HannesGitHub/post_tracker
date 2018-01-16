class Admin::AdminDashboardController < Admin::BaseAdminController
  def index
    puts "**************************************#{Figaro.env.domain}***********************************"
  end
end