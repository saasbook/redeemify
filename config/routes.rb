Auth::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config

  root to: "sessions#new"
  get 'sessions/customer'
  get 'sessions/index'
  get 'sessions/show'
  get 'sessions/enter'
  get 'sessions/delete_page'
  get 'sessions/delete_account'
  get 'vendors/home'
  get 'vendors/edit'
  get 'vendors/upload_page'
  get 'vendors/viewCodes'
  get 'vendors/profile'
  get 'vendors/remove_codes'
  get 'vendors/change_to_user'
  get 'vendors/clear_history'
  get 'sessions/change_to_vendor'
  get 'admin/login'

  get 'vendors/new'


  get 'providers/index'
  get 'providers/home'
  get 'providers/edit'
  get 'providers/upload_page'
  get 'providers/remove_codes'
  get 'providers/clear_history'


  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"
  match "/logout", to: "vendors#destroy", :as => "logout2"
  resources :sessions
  resources :users do
    resources :vendorcodes
    resources :provider
  end

  
  resources :vendors do
    collection {post :import}
    collection {post :update_profile}
    resources :vendorcodes
  end


  resources :providers do
    collection {post :import2}
    collection {post :update_profile}
    resources :providercodes
  end
  ActiveAdmin.routes(self)
end
