Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'login/welcome#landing'
  namespace 'login' do

  end

  namespace 'admin' do
    root 'landing_page#index'

    controller :admin_users do
      get 'users' => :index
      get 'users/new' => :new
    end

  end
end
