class Admin::AdminDashboardController < Admin::BaseAdminController
  def index
    puts "**************************************#{Figaro.env.website_domain}***********************************"
  end
end