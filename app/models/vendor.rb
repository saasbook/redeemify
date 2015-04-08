class Vendor < ActiveRecord::Base 
	require 'csv'
	has_many :vendorCodes
	attr_accessible :history, :provider, :email, :name , :description, :website

  	def self.import(file, current_vendor, info)
  		numberOfCodes = 0
  		date = ""
    	CSV.foreach(file.path, headers: true) do |row|

	      	code = row.to_hash # exclude the price field
	      	# debugger
	      	a = current_vendor.vendorCodes.create!(:code => code["code"], :name => current_vendor.name , :vendor => current_vendor, :instruction => info["instruction"], :help => info["help"], :expiration => info["expiration"])
	      	numberOfCodes = numberOfCodes + 1
	      	date = a.created_at
		end # end CSV.foreach
		history = current_vendor.history
		
	    # temp = date.to_s #+ "," #+ info["description"]+ "," + info["expiration"] + "," + numberOfCodes.to_s + "||||"
	    date = date.to_formatted_s(:long_ordinal)
	    if history == nil
		    history = "#{date}+++++#{info["description"]}+++++#{info["expiration"]}+++++#{numberOfCodes.to_s}|||||"
	    else
	    	history = "#{history}#{date}+++++#{info["description"]}+++++#{info["expiration"]}+++++#{numberOfCodes.to_s}|||||"
	    end
	    current_vendor.update_attribute(:history, history)

  	end # end self.import(file)

end