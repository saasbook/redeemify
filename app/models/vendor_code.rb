class VendorCode < ActiveRecord::Base
	belongs_to :vendor
	belongs_to :user
    attr_accessible :code, :name , :vendor , :user_id, :instruction, :help, :expiration, :vendor_id
end
