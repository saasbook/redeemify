class VendorCode < ActiveRecord::Base
	belongs_to :vendor
	belongs_to :user
	belongs_to :redeemify_code
	
  def assign_to(current_user)
    self.update_attributes(user: current_user, user_name: current_user.name, email: current_user.email)
    vendor = self.vendor
    vendor.update_attribute(:usedCodes, vendor.usedCodes + 1)
    vendor.update_attribute(:unclaimCodes, vendor.unclaimCodes - 1)
  end  

	
end
