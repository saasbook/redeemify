ActiveAdmin.register ProviderCode do
  menu :priority => 6
  permit_params :user_name, :email, :code
  
index do
    column :user_name
    column :email
    column :code
    column "Provider", :name
    column :created_at
  end
  filter :user_name
  filter :email
  filter :code
end
