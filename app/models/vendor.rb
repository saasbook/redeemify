class Vendor < ActiveRecord::Base
  include Offeror
  has_many :vendorCodes
  
  before_create :default_value
  
  def default_value
    self.used_codes = 0
    self.uploaded_codes = 0
    self.unclaimed_codes = 0
    self.removed_codes = 0
  end
  
  def self.update_profile_vendor(current_vendor, info)
    current_vendor.update(:cash_value => info["cash_value"],
      :expiration => info["expiration"], :help_link => info["help_link"],
      :instruction => info["instruction"], :description => info["description"])
  end
  
  def serve_code(user)
    code = self.vendorCodes.where(user_id: user.id).first ||
      self.vendorCodes.where(user_id: nil).first
    unless code.nil?
      if code.user_id.nil? && self.vendorCodes.find_by(user_id: user.id).nil?
        code.associate_with(user)
      end
    end
    code
  end
end
