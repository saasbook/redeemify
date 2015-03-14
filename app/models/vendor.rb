class Vendor < ActiveRecord::Base 
	attr_accessible :uid, :name, :provider 
end