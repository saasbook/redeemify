Auth::Application.routes.draw do
  root to: "sessions#new"
  get 'sessions/offer'
  get 'sessions/index'
  get 'vendors/new'
  match "/auth/:provider/callback", to: "sessions#create"
  match "/auth/failure", to: "sessions#failure"
  match "/logout", to: "sessions#destroy", :as => "logout"
  resources :sessions
end
