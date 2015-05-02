ActiveAdmin.register VendorCode do
  menu :priority => 7
  index do   
    column "User Name", :user_name
    column :email                                                
    column :code
    column "Vendor", :name
    column :created_at                                     
  end
  
  # filter :name, label: "Vendor", :as => :select, :collection => Vendor.all.map{|u| ["#{u.name}", u.name]}
  filter :name, label: "Vendor"
  filter :user_name, label: "User Name"
  filter :email
  filter :code
end