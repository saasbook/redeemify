ActiveAdmin.register VendorCode do
  menu :priority => 7
  permit_params :email, :code, :user_name, :name
  index do
    column "User Name", :user_name
    column :email
    column :code
    column "Vendor", :name
    column :created_at

    column "" do |vendor_code|

      links = ''.html_safe
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(vendor_code), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(vendor_code), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end
  end

  form do |f|
    f.inputs "Vendor Code Details" do
      f.input :user_name
      f.input :email
      f.input :code
      f.input :name
    end
    f.actions
  end

  # filter :name, label: "Vendor", :as => :select, :collection => Vendor.all.map{|u| ["#{u.name}", u.name]}
  filter :name, label: "Vendor"
  filter :user_name, label: "User Name"
  filter :email
  filter :code
end
