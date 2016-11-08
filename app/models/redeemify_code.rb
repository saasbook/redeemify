class RedeemifyCode < ActiveRecord::Base
	belongs_to :provider
	belongs_to :user
  has_many :vendor_codes
  #accepts_nested_attributes_for :vendor_codes

  validates_presence_of :code
end
