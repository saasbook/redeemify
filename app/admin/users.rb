ActiveAdmin.register User do
  menu :priority => 5 
index do                            
    column :name                         
    column :code
    column "Log In With", :provider
    column :created_at 
    column "" do |user|
      links = ''.html_safe
      links += link_to I18n.t('active_admin.edit'), edit_resource_path(user), :class => "member_link edit_link"
      links += link_to I18n.t('active_admin.delete'), resource_path(user), :method => :delete, :confirm => I18n.t('active_admin.delete_confirmation'), :class => "member_link delete_link"
      links
    end                 	                 
  end
  filter :name 
  filter :provider ,label: 'Log In With', :as => :select, :collection => { :Amazon => "amazon", :Google => "google_oauth2", :GitHub => "github", :Twitter => "twitter", :Facebook => "facebook"}

  form do |f|                         
    f.inputs "User Details" do       
      f.input :name                
      f.input :code             
    end                               
    f.actions                         
  end 
end
