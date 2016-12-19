class RedeemifyCode < ActiveRecord::Base
  belongs_to :provider
  belongs_to :user
  has_many :vendor_codes
  #accepts_nested_attributes_for :vendor_codes

  validates_presence_of :code
  
  def self.serve_for(code)
    RedeemifyCode.where(:code => code, :user => nil).first
  end
  
  def assign_to(current_user)
    self.update_attributes(:user_id => current_user.id, :user_name => current_user.name, :email => current_user.email)
    provider = self.provider
    #debugger
    provider.update_attribute(:usedCodes, provider.usedCodes + 1)
    provider.update_attribute(:unclaimCodes, provider.unclaimCodes - 1)
  end
  
end
