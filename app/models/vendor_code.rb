class VendorCode < ActiveRecord::Base
	belongs_to :vendor
	belongs_to :user
	# TODO: USE STRONG PARAMETERS
	# attr_accessible :code, :name , :vendor , :user_id, :vendor_id , :user_name, :email, :instruction, :help, :expiration
end
