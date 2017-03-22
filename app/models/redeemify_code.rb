class RedeemifyCode < ActiveRecord::Base
  belongs_to :provider
  belongs_to :user
  has_many :vendor_codes
  #accepts_nested_attributes_for :vendor_codes

  validates_presence_of :code
  validates :code, presence: true,  uniqueness: {message: "already registered"},
                  length: { maximum: 255, message: "longer than 255 characters" }
  
  def self.serve(user, code)
    redeemify_code = self.where(code: code, user: nil).first
    if redeemify_code
      redeemify_code.assign_to user
      user.code = code
      user.save!
    end
  end
  
  def assign_to(user)
    self.update_attributes(user_id: user.id, user_name: user.name,
      email: user.email)
    provider = self.provider
    provider.update_attribute(:usedCodes, provider.usedCodes + 1)
    provider.update_attribute(:unclaimCodes, provider.unclaimCodes - 1)
  end
  
  def self.anonymize!(user)
      redeemify_code = find_by user: user
      if redeemify_code
        redeemify_code.user_name = "anonymous"
        redeemify_code.email = "anonymous@anonymous.com"
        redeemify_code.save!
      end  
  end
end
