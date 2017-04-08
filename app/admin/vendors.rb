ActiveAdmin.register Vendor do
  menu :priority => 4
  permit_params :name, :email, :provider, :cash_value, :expiration, :website,
    :help_link, :instruction, :help, :expiration

  index do
    column :name
    column :email
    column "Log in through", :provider
    column :cash_value
    column :expiration
    column :website
    column "# Used Codes", :used_codes
    column "# Unclaimed Codes", :unclaimed_codes
    column "# Uploaded Codes", :uploaded_codes
    column "# Removed Codes", :removed_codes
    actions
  end
  config.filters = false
  form partial: '/admin/form'
end
