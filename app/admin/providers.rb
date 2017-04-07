ActiveAdmin.register Provider do
  menu :priority => 3
  permit_params :name, :email, :provider

  index do
    column :name
    column :created_at
    column :email
    column "# Used Codes", :used_codes
    column "# Unclaim Codes", :unclaimed_codes
    column "# Uploaded Codes", :uploaded_codes
    column "# Removed Codes", :removed_codes
    actions
  end
  config.filters = false
  form partial: 'admin/form'
end
