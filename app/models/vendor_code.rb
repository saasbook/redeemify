class VendorCode < ActiveRecord::Base
	belongs_to :vendor
	belongs_to :user
    attr_accessor :code, :name , :vendor , :user_id, :vendor_id , :user_name, :email, :instruction, :help, :expiration
end
