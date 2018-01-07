class Login::BaseLoginController < ::Devise::SessionsController
  layout "admin"
  # the rest is inherited, so it should work
end