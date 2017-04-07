ActiveAdmin.register VendorCode do
  menu :priority => 7
  permit_params :code, :user_name, :email, :name
  actions :all, :except => [:new, :edit]
  
  index do
    column "Vendor", :name
    column :code
    column :created_at
    column :user_name
    column :email
    actions
  end
  # filter :name, label: "Vendor", :as => :select,
  #   :collection => Vendor.all.map{|u| ["#{u.name}", u.name]}
  filter :name, label: "Vendor"
  filter :user_name
  filter :email
  filter :code
end
