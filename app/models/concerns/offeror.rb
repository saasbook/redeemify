module Offeror
  
  def self.import(file, offeror, comment)
    @processed_codes, @approved_codes = {submitted_codes: 0}, 0
    @processed_codes[:err_file] = file_check(file.path)
    return @processed_codes if @processed_codes[:err_file]
    
    process_codes(file, offeror)
    
    update_history(offeror, comment)

    return @processed_codes
  end
  
  def self.remove_unclaimed_codes(offeror)
    define_role(offeror)
    
    remove_codes(offeror)
    
    reflect_in_history(offeror)
    
    offeror.update(unclaimCodes: 0, removedCodes: offeror.removedCodes + @num)
    return @contents
  end
  
  def self.home_set(histories)
    if histories.blank?
      return []
    else
      histories = histories.split(/\n/)
      histories_array = []
      histories.each do |history|
        temp = history.split(/\t/)
        histories_array.push(temp)
      end
      histories_array.reverse!
      return histories_array
    end
  end
  
  private
  
  def self.file_check(file_path)
    return "Wrong file format! Please upload '.txt' file" unless file_path =~/.txt$/
    return "No codes detected! Please check your upload file" if File.zero? file_path
  end
  
  def self.process_codes(file, offeror)
    f = File.open(file.path, "r")
      f.each_line do |row|
        row = row.gsub(/\s+/, "") # eliminate spaces in a row
        if row != ""
          @processed_codes[:submitted_codes] += 1
          begin
            a = add_code(offeror, row)
            a.save!
            @approved_codes += 1
          rescue
            err_str = a.errors[:code].join(', ')
            @processed_codes[err_str] ||= []
            @processed_codes[err_str] << a.code
          end
          @processed_codes[:err_codes] =
            @processed_codes[:submitted_codes] - @approved_codes
        end
      end
    f.close
    offeror.update(uploadedCodes: offeror.uploadedCodes + @approved_codes,
      unclaimCodes: offeror.unclaimCodes + @approved_codes)
  end
  
  def self.add_code(offeror, code)
    if offeror.is_a? Vendor
      offeror.vendorCodes.build(code: code, name: offeror.name, vendor: offeror)
    else
      offeror.redeemifyCodes.build(code: code, name: offeror.name,
        provider: offeror)
    end
  end
  
  def self.update_history(offeror, comment)
    history = offeror.history
    date = Time.now.to_formatted_s(:long_ordinal)
    if history.nil?
      history = "#{date}\t#{comment}\t#{@approved_codes}\n"
    else
      history = "#{history}#{date}\t#{comment}\t#{@approved_codes}\n"
    end
    offeror.update_attribute(:history, history)
  end
  
  def self.define_role(offeror)
    if offeror.is_a? Vendor
      @unclaimed_codes = offeror.vendorCodes.where(:user_id => nil)
    else
      @unclaimed_codes = offeror.redeemifyCodes.where(:user_id => nil)
    end
  end
  
  def self.remove_codes(offeror)
    @num = offeror.unclaimCodes
    @date = Time.now.to_formatted_s(:long_ordinal)
    @contents = "There are #{@num} unclaimed codes, removed on #{@date}\r\n\r\n"
    @unclaimed_codes.each do |code|
      @contents = "#{@contents}#{code.code}\r\n"
      code.destroy
    end
  end
  
  def self.reflect_in_history(offeror)
    history = offeror.history
    history = "#{history}#{@date}\tCodes were removed\t-#{@num}\n"
    offeror.update_attribute(:history, history)
  end
end