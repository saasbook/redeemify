Auth::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  

  root to: "sessions#new"
  get 'sessions/customer'
  get 'sessions/index'
  get 'sessions/show'
  get 'sessions/enter'
  get 'vendors/home'
  get 'vendors/edit'
  get 'vendors/upload_page'
  get 'vendors/viewCodes'

  get 'vendors/new'
  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"
  match "/logout", to: "vendors#destroy", :as => "logout2"
  resources :sessions
  resources :users do
    resources :vendorcodes
  end
  
  resources :vendors do
    collection {post :import}
    resources :vendorcodes
  end
  
  ActiveAdmin.routes(self)
end
