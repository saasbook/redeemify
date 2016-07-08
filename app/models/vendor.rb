class Vendor < ActiveRecord::Base 
	# require 'csv'
	has_many :vendorCodes
	attr_accessor :history, :provider, :email, :name , :description, :instruction, :website, :comment , :helpLink, :expiration, :cashValue, :usedCodes, :uploadedCodes, :unclaimCodes, :removedCodes
	before_create :defaultValue

	def defaultValue
		self.usedCodes = 0
		self.uploadedCodes = 0
		self.unclaimCodes = 0
		self.removedCodes = 0
		self.cashValue = "0.00"
	end


  	def self.import(file, current, comment, type)
  		numberOfCodes = 0
  		date = ""
    	f = File.open(file.path, "r")
		f.each_line do |row|
			row = row.gsub(/\s+/, "")  # 12 3 4 --> 1234, 
			if row !=  ""   # don't get any blank code
				if type == "vendor"	
			      	a = current.vendorCodes.create!(:code => row, :name => current.name , :vendor => current)
			   
			    else
			    	a = current.providerCodes.create!(:code => row, :name => current.name , :provider => current)
			    end
			    numberOfCodes = numberOfCodes + 1
		    end
		end # end CSV.foreach
		f.close
		history = current.history
		
	    date = Time.now.to_formatted_s(:long_ordinal)
	    if history == nil
	    	history = "#{date}+++++#{comment}+++++#{numberOfCodes.to_s}|||||"
	    else
	    	history = "#{history}#{date}+++++#{comment}+++++#{numberOfCodes.to_s}|||||"
	    end
	    current.update_attribute(:history, history)
	    current.update_attribute(:uploadedCodes, current.uploadedCodes + numberOfCodes)
	    current.update_attribute(:unclaimCodes, current.unclaimCodes + numberOfCodes)


  	end # end self.import(file)


  	def self.update_profile_vendor(current_vendor,info)
  		current_vendor.update_attributes(:cashValue => info["cashValue"], :expiration => info["expiration"], :helpLink => info["helpLink"],:instruction => info["instruction"], :description => info["description"])
  	end # end self.profile()

  	def self.remove_unclaimed_codes(current, type)
  		unclaimed = ""
  		if type == "vendor"
  			unclaimedCodes=current.vendorCodes.where(:user_id => nil)
  		else
  			unclaimedCodes=current.providerCodes.where(:user_id => nil)
  		end

  		num = current.unclaimCodes
  		date = Time.now.to_formatted_s(:long_ordinal)

  		history = current.history
  		history = "#{history}#{date}+++++Delete Codes+++++-#{num.to_s}|||||"
  		current.update_attribute(:history, history)

  		contents = "There're #{num} unclaimed codes, remove on #{date}\n\n"
  		unclaimedCodes.each do |code|
  			contents = "#{contents}#{code.code}\n"
  			code.destroy
  		end
  		current.update_attribute(:unclaimCodes, 0)
  		current.update_attribute(:removedCodes, current.removedCodes + num)

  		return contents
  	end


  	def self.homeSet(histories)
		histories = histories.split("|||||")

		histories_array=[]
		histories.each do |history|
			temp = history.split("+++++")
			histories_array.push(temp)
		end
		histories_array.reverse!

	    return histories_array
  	end

  

end
