class ProviderCode < ActiveRecord::Base
	belongs_to :provider
	belongs_to :user
	#TODO: USE STRONG PARAMETERS
	#attr_accessible :code, :name, :provider_id, :user_id, :provider, :user_name, :email
end
