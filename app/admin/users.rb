ActiveAdmin.register User do
  menu :priority => 5
  actions :all, :except => [:new, :edit]
  permit_params :name, :code

  index do
    column :name
    column :email
    column :code
    column "Log in through", :provider
    column :created_at
    actions
  end
  filter :name
  filter :provider, label: 'Log in through', :as => :select, 
    :collection => { :Amazon => "amazon", :Google => "google_oauth2", 
    :GitHub => "github", :Twitter => "twitter", :Facebook => "facebook" }
end
