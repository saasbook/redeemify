class VendorCode < ActiveRecord::Base
	belongs_to :vendor
	belongs_to :user
	belongs_to :redeemify_code
end
