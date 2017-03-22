class Vendor < ActiveRecord::Base
  include Offeror
  has_many :vendorCodes
  
  before_create :default_value
  
  def default_value
    self.usedCodes = 0
    self.uploadedCodes = 0
    self.unclaimCodes = 0
    self.removedCodes = 0
  end
  
  def self.update_profile_vendor(current_vendor, info)
    current_vendor.update_attributes(:cashValue => info["cashValue"],
      :expiration => info["expiration"], :helpLink => info["helpLink"],
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
