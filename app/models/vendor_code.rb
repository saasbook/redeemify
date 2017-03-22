class VendorCode < ActiveRecord::Base
	belongs_to :vendor
	belongs_to :user
	belongs_to :redeemify_code
	
  validates :code, presence: true,  uniqueness: {message: "already registered"},
                   length: { maximum: 255, message: "longer than 255 characters" }
	
	
  def associate_with(user)
    self.update(user_id: user.id, user_name: user.name, email: user.email)
    vendor = self.vendor
    vendor.update_attribute(:usedCodes, vendor.usedCodes + 1)
    vendor.update_attribute(:unclaimCodes, vendor.unclaimCodes - 1)
  end

  def self.anonymize_all!(myUser)
    vCodes = where user: myUser
    vCodes.update_all user_name: "anonymous", email: "anonymous@anonymous.com" if vCodes
  end  
	
end
