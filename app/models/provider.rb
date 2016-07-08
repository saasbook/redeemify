class Provider < ActiveRecord::Base
	has_many :providerCodes
  	attr_accessor :email, :history, :name, :provider, :usedCodes, :uploadedCodes, :unclaimCodes, :removedCodes

  	before_create :defaultValue

	def defaultValue
		self.usedCodes = 0
		self.uploadedCodes = 0
		self.unclaimCodes = 0
		self.removedCodes = 0
	end

  	
end
