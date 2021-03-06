Rails.application.routes.draw do
  root 'login/welcome#sign_in'

  scope module: 'login' do
    get 'sign_in', to: 'welcome#sign_in'
    post 'authenticate', to: 'welcome#authenticate'
    get 'confirm_account/:token', to: 'welcome#confirm_account', as: 'confirm_account'
    get 'confirmation_successful/:id', to: 'welcome#confirmation_successful', as: 'confirmation_successful'
    get 'sign_up', to: 'welcome#sign_up'
    post 'request_signup', to: 'welcome#request_signup'
    get 'sign_up_successful', to: 'welcome#signup_successfull_and_pending'
    post 'set_password', to: 'welcome#set_password'
    patch 'set_password', to: 'welcome#set_password'
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
      get 'user/:id/edit' => :edit, as: 'edit_user'
      patch 'users/update' => :update
      get 'users/:id/delete' => :delete, as: 'delete_user'
    end

    controller :admin_dashboard do
      get 'dashboard' => :index
    end
  end

  namespace 'users' do
    root 'users_dashboard#index'
    controller :trackings do
      get 'trackings' => :index
      get 'completed_trackings' => :completed_trackings, as: 'completed_trackings'
      get 'failed_trackings' => :failed_trackings, as: 'failed_trackings'
      get 'trackings/new' => :new
      post 'trackings/create' => :create
      get 'trackings/:id/show' => :show
      get 'trackings/:id/edit' => :edit, as: 'edit_tracking'
      patch 'trackings/update' => :update
      get 'trackings/:id/delete' => :delete, as: 'delete_tracking'
      get 'trackings/:id/mark_as_completed' => :mark_completed, as: 'mark_completed'
      get 'trackings/:id/retry_tracking' => :retry_tracking, as: 'retry_tracking'

      #   Trackings AJAX routes
      get 'trackings/:id/get_statuses' => :statuses, as: 'tracking_statuses'
    end
    controller :active_user do
      patch 'update_user_settings' => :update_user_settings, as: 'update_user_settings'
    end
  end

  namespace 'track_more' do
    controller :track_more do
      post 'trackmore_webhook' => :webhook_received
    end
  end
end