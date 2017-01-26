require 'rails_helper'

RSpec.describe Vendor, :type => :model do
  # pending "add some examples to (or delete) #{__FILE__}"

  it 'sets correct cash value (#cashValue)' do
    vendor = FactoryGirl.create(:vendor)
    expect(vendor.cashValue).not_to eq("0.00")
  end

  it '#cashValue' do
    vendor = FactoryGirl.create(:vendor)
    expect(vendor.cashValue).to eq("$10")
  end
  
  describe '#serve_code' do
    before :all do
      @vendor = FactoryGirl.create :vendor
      @vendor.vendorCodes.create code: "MyCode"
      (1..3).each do |i| 
        @vendor.vendorCodes.create code: "000" + i.to_s,
          user: FactoryGirl.create(:user, email: "email_#{i}@domain.com")
      end  
      @myUser = FactoryGirl.create :user
    end  
    
    it "serves vendor code for new user" do
      expect(@vendor.serve_code @myUser).to be_truthy
      expect((@vendor.serve_code @myUser).code).to match(/MyCode/)
    end
    
    it "serves vendor code for returning user" do
      @vendor.serve_code @myUser
      expect((@vendor.serve_code @myUser).code).to match(/MyCode/)
    end
    
    it "returns nil when codes for a given vendor have already been served" do
      newUser = FactoryGirl.create :user, name: "Joe", email: "new@email.com"
      @vendor.serve_code @myUser
      expect(@vendor.serve_code newUser).to be_falsy
    end  
  end
  
    describe 'Vendor.import' do
      include Rack::Test::Methods
      include ActionDispatch::TestProcess
      
      before :all do
        
        @codesFile = fixture_file_upload("test.txt")
        @erCodesFile = fixture_file_upload("invalid_codes_test.txt")
        @vendor = FactoryGirl.create :vendor
        @provider = FactoryGirl.create :provider
        #@codesFile = Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/test.txt"))
        #@erCodesFile = Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/invalid_codes_test.txt"))
        @comment = "Test Comment"
      end  
    
     it "updates the number of Vendor codes by the number of unique valid strings in the upload file" do
       expect{Vendor.import(@codesFile, @vendor, @comment, "vendor")}.to change {@vendor.uploadedCodes}.by(3)
     end   
   
     it "updates the number of Redeemify codes by the number of unique valid strings in the upload file" do
       expect{Vendor.import(@codesFile, @provider, @comment, "provider")}.to change {@provider.uploadedCodes}.by(3)
     end   
   
     it "returns vendor codes serializing report as a Hash instance" do
       expect(Vendor.import(@codesFile, @vendor, @comment, "vendor")).to be_an_instance_of Hash
     end
     
     it "returns Redeemify codes serializing report as a Hash instance" do
       expect(Vendor.import(@codesFile, @provider, @comment, "provider")).to be_an_instance_of Hash
     end
     
     it "returns, for vendor codes, a Hash instance having :errCodes and :submittedCodes as keys" do
       expect(Vendor.import(@codesFile, @vendor, @comment, "vendor")).to match errCodes: an_instance_of(Fixnum), submittedCodes: an_instance_of(Fixnum)
     end
     
     it "returns, for Redeemify codes, a Hash instance having :errCodes and :submittedCodes as keys" do
       expect(Vendor.import(@codesFile, @provider, @comment, "provider")).to match errCodes: an_instance_of(Fixnum), submittedCodes: an_instance_of(Fixnum)
     end
     
     it "returns, for vendor codes, a Hash instance with validation errors as strings each related to arrays of rejected codes" do
       expect(Vendor.import(@erCodesFile, @vendor, @comment, "vendor")).to match(
         errCodes: an_instance_of(Fixnum), 
         submittedCodes: an_instance_of(Fixnum),
         "already registered" => an_instance_of(Array),
         "longer than 255 characters" => an_instance_of(Array))
     end   
     
     it "returns, for Redeemify codes, a Hash instance with validation errors as strings each related to arrays of rejected codes" do
       expect(Vendor.import(@erCodesFile, @provider, @comment, "provider")).to match(
         errCodes: an_instance_of(Fixnum), 
         submittedCodes: an_instance_of(Fixnum),
         "already registered" => an_instance_of(Array),
         "longer than 255 characters" => an_instance_of(Array))
     end   
     
    end

end
