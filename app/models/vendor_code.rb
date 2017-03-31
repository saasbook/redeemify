class VendorCode < ActiveRecord::Base
  include Offeror
	belongs_to :vendor
	belongs_to :user
	belongs_to :redeemify_code
	
  validates :code, presence: true,  uniqueness: {message: "already registered"},
                   length: { maximum: 255, message: "longer than 255 characters" }
	
	
  def associate_with(user)
    self.update(user_id: user.id, user_name: user.name, email: user.email)
    update_codes_statistics(self.vendor)
  end

  def self.anonymize_all!(user)
    vendor_codes = where(user: user)
    vendor_codes.update_all(user_name: "anonymous",
      email: "anonymous@anonymous.com") if vendor_codes
  end
end
