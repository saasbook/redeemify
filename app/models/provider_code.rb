class ProviderCode < ActiveRecord::Base
	belongs_to :provider
	belongs_to :user
	attr_accessor :code, :name, :provider_id, :user_id, :provider, :user_name, :email
end
