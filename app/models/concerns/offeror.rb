module Offeror

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

  def import(file, comment)
    @processed_codes, @approved_codes = {submitted_codes: 0}, 0
    @processed_codes[:err_file] = file_check(file.path)
    return @processed_codes if @processed_codes[:err_file]
    
    process_codes(file)
    
    update_history(comment)
    
    return @processed_codes
  end
  
  def remove_unclaimed_codes(offeror_codes)
    @unclaimed_codes = offeror_codes.where(user_id: nil)
    @num = self.unclaimCodes
    @unclaimed_codes.each do |code|
      code.destroy
    end
    
    comment = "Codes were removed"
    update_history(comment)
    self.update(unclaimCodes: 0, removedCodes: self.removedCodes + @num)
  end
  
  def download_unclaimed_codes(offeror_codes)
    @unclaimed_codes = offeror_codes.where(user_id: nil)
    @num = self.unclaimCodes
    @date = Time.now.to_formatted_s(:long_ordinal)
    @contents = "There are #{@num} unclaimed codes, downloaded on #{@date}\r\n\r\n"
    @unclaimed_codes.each do |code|
      @contents = "#{@contents}#{code.code}\r\n"
    end
    return @contents
  end

  private
  
  def file_check(file_path)
    return "Wrong file format! Please upload '.txt' file" unless file_path =~/.txt$/
    return "No codes detected! Please check your upload file" if File.zero? file_path
  end

  def process_codes(file)
    f = File.open(file.path, "r")
      f.each_line do |row|
        row = row.gsub(/\s+/, "")
        unless row.empty?
          @processed_codes[:submitted_codes] += 1
          begin
            a = add_code(row)
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
    self.update(uploadedCodes: self.uploadedCodes + @approved_codes,
      unclaimCodes: self.unclaimCodes + @approved_codes)
  end

  def add_code(code)
    if self.is_a? Vendor 
      self.vendorCodes.build(code: code, name: self.name)
    else
      self.redeemifyCodes.build(code: code, name: self.name)
    end
  end

  def update_history(comment)
    history = self.history
    date = Time.now.to_formatted_s(:long_ordinal)
    if history.nil?
      history = "#{date}\t#{comment}\t#{@approved_codes}\n"
    else
      history = "#{history}#{date}\t#{comment}\t#{@approved_codes}\n"
    end
    self.update_attribute(:history, history)
  end
end