class Provider < ActiveRecord::Base
	has_many :redeemifyCodes

  before_create :defaultValue

	def defaultValue
		self.usedCodes = 0
		self.uploadedCodes = 0
		self.unclaimCodes = 0
		self.removedCodes = 0
	end

end
