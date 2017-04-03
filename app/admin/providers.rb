ActiveAdmin.register Provider do
  menu :priority => 3
  permit_params :name, :email
  
  index do
    column :name
    column :created_at
    column :email

    column "# Used Codes", :used_codes
    column "# Unclaim Codes", :unclaimed_codes

    column "# Uploaded Codes", :uploaded_codes
    column "# Removed Codes", :removed_codes

    column "" do |provider|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(provider),
        :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(provider),
        :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'),
        :class => "member_link delete_link"
      links
    end
  end
  config.filters= false

  form do |f|
    f.inputs "Vendor Details" do
      f.input :name
      f.input :email
      f.input :provider, label: 'Log In With', :as => :select,
        :collection => { :Amazon => "amazon", :Google => "google_oauth2",
        :GitHub => "github", :Twitter => "twitter", :Facebook => "facebook" }
    end
    f.actions
  end
end
