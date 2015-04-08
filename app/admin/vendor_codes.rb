ActiveAdmin.register VendorCode do
index do   
    column :user_id                                                  
    column :code
    column :vendor
    column :created_at
    column :expiration                                     
  end
  filter :vendor
  filter :user_id
  filter :code
end