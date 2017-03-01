class Provider < ActiveRecord::Base
	include Offeror
	has_many :redeemifyCodes

  before_create :default_value

	def default_value
		self.usedCodes = 0
		self.uploadedCodes = 0
		self.unclaimCodes = 0
		self.removedCodes = 0
	end

end
