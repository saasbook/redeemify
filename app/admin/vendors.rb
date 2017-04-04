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
    column :help_link

    column "# Used Codes", :used_codes
    column "# Unclaimed Codes", :unclaimed_codes

    column "# Uploaded Codes", :uploaded_codes
    column "# Removed Codes", :removed_codes


    column "" do |vendor|

      links = ''.html_safe
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(vendor),
        :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(vendor),
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
      f.input :website
    end
    f.actions
  end
end
