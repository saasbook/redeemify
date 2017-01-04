class RedeemifyCode < ActiveRecord::Base
  belongs_to :provider
  belongs_to :user
  has_many :vendor_codes
  #accepts_nested_attributes_for :vendor_codes

  validates_presence_of :code
  
  def self.serve(myUser, myCode)
    rCode = self.where(code: myCode, user: nil).first #look up newcomer's provider token
    if rCode #happy path: redeem the token
      rCode.assign_to myUser
      myUser.code = myCode
      myUser.save!
    end
  end
  
  def assign_to(myUser)
    self.update_attributes(:user_id => myUser.id, :user_name => myUser.name, :email => myUser.email)
    provider = self.provider
    provider.update_attribute(:usedCodes, provider.usedCodes + 1)
    provider.update_attribute(:unclaimCodes, provider.unclaimCodes - 1)
  end
  
  def self.anonymize!(myUser)
      rCode = find_by user: myUser
      if rCode
        rCode.user_name = "anonymous"
        rCode.email = "anonymous@anonymous.com"
        rCode.save!
      end  
  end
  
  
end
