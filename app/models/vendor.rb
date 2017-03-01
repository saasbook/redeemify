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
	
	def serve_code(myUser)
		code = self.vendorCodes.where(user: myUser).first ||
			self.vendorCodes.where(user: [0,nil]).first
		unless code.nil?
			if code.user_id.nil? && self.vendorCodes.find_by(user: myUser).nil?
				code.assign_to myUser
			end
		end
		code
	end
end
