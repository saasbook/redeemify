ActiveAdmin.register RedeemifyCode do
  menu :priority => 6
  permit_params :user_name, :email, :code
  actions :all, :except => [:new, :edit]
  
  index do
    column "Provider", :name
    column :code
    column :created_at
    column :user_name
    column :email
    actions
  end
  filter :name, label: "Provider"
  filter :user_name
  filter :email
  filter :code
end
