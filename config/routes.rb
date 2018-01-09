Rails.application.routes.draw do
  root 'login/welcome#landing'

  scope module: 'login' do
    get 'sign_in', to: 'welcome#sign_in'
    post 'authenticate', to: 'welcome#authenticate'

    get 'confirm_account/:token', to: 'welcome#confirm_account', as: 'confirm_account'
    get 'confirmation_successful', to: 'welcome#confirmation_successful'
    get 'sign_up', to: 'welcome#sign_up'
    post 'request_signup', to: 'welcome#request_signup'
    get 'sign_up_successful', to: 'welcome#signup_successfull_and_pending'
  end
  namespace 'login' do

  end
  namespace 'admin' do
    root 'landing_page#index'
    controller :admin_users do
      get 'users' => :index
      get 'users/new' => :new
      post 'users/create' => :create
      get 'users/:id/show' => :show
      get 'users/:id/approve' => :approve
    end
  end
  namespace 'users' do

  end
end