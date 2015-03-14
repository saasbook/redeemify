Auth::Application.routes.draw do
  root to: "sessions#new"
  get 'sessions/offer'
  get 'sessions/index'
  get 'sessions/show'
  get 'sessions/enter'
  get 'vendors/home'
  get 'vendors/edit'

  get 'vendors/new'
  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"
  match "/logout", to: "vendors#destroy", :as => "logout2"
  resources :sessions
  resources :vendors
end
