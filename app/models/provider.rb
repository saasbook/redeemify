class Provider < ActiveRecord::Base
	include Offeror
	has_many :redeemifyCodes

  before_create :default_value

	def default_value
		self.used_codes = 0
		self.uploaded_codes = 0
		self.unclaimed_codes = 0
		self.removed_codes = 0
	end

end
