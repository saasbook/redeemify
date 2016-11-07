class RedeemifyCode < ActiveRecord::Base
	belongs_to :provider
	belongs_to :user

  validates_presence_of :code
end
