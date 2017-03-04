require 'spec_helper'
require 'rails_helper'
 
describe VendorsController do

  describe "#home" do
    render_views  
    it "renders the about template" do
      expect(session[:vendor_id]).to be_nil

      v = Vendor.create :name => "thai" , :uid => "54321", :provider => "amazon"
      v.history = "April 3rd, 2015 23:51\tCode Description\t2\n"
      v.save!

      session[:vendor_id] = v.id
      expect(session[:vendor_id]).not_to be_nil
      get 'profile' # or :new
      expect(response).to render_template :profile

      get 'upload_page'
      expect(response).to render_template :upload_page

      get 'view_codes'
      expect(response).to render_template :view_codes
    end
    
    it "renders the home page showing vendor's provider" do
      amazon = FactoryGirl.create(:vendor)
      allow(controller).to receive(:current_vendor).and_return(amazon)
      get :home
      expect(response).to render_template(:home)
      expect(response.body).to match(/Amazon Oauth/i)
    end

  end

  describe "#edit" do
     it "renders the about template" do
        get :edit
        expect(response).to render_template :edit
    end
  end

  describe "#index" do
     it "renders the about template" do
        get 'index' # or :new
        expect(response).to render_template :index
    end
  end

  describe "#upload_page" do
    render_views
    it "renders the upload page with the vendor's provider" do
      amazon = FactoryGirl.create(:vendor)
      allow(controller).to receive(:current_vendor).and_return(amazon)
      get :upload_page
      expect(response).to render_template(:upload_page)
      expect(response.body).to match(/Amazon Oauth/i)
    end
  end
  
  describe "#profile" do
    render_views
    it "renders the profile page with vendor's expiration, description, helpLink, instruction" do
      amazon = FactoryGirl.create(:vendor)
      allow(controller).to receive(:current_vendor).and_return(amazon)
      get :profile
      expect(response).to render_template(:profile)
      
      expect(response.body).to match(/MyExpiration/)
      expect(response.body).to match(/MyDescription/)
      expect(response.body).to match(/MyHelpLink/)
      expect(response.body).to match(/MyInstruction/)      
    end
  end

  describe "#import" do
    render_views
    before do
      @vendor = create(:vendor)
      @hash = {err_codes: 0, submitted_codes: 5}
      @err_hash = {err_codes: 2, submitted_codes: 5}
    end  

    it "renders the upload page and notifies user when no file is picked to upload" do
      post :import
      expect(response).to redirect_to(:vendors_upload_page)
      expect(flash[:error]).to eq("You have not selected a file to upload")
    end
    
    it "redirects to the home page and notifies user of codes successfully uploaded" do
      allow(controller).to receive(:current_vendor).and_return(@vendor)
      allow(@vendor).to receive(:import).and_return(@hash)
      post :import, file: !nil
      expect(response).to redirect_to(:vendors_home)
      expect(flash[:notice]).to match(/5 codes imported/)
    end
    
    it "calls #validation_errors_content to generate report content" do
      allow(controller).to receive(:current_vendor).and_return(@vendor)
      allow(@vendor).to receive(:import).and_return(@err_hash)
      expect(controller).to receive(:validation_errors_content).with(@err_hash)
      post :import, file: !nil
    end  

    it "calls #send_data prompting user to download error report" do
      content = "N codes submitted to update the code set"
      file = {filename: "#{@err_hash[:err_codes]}_codes_rejected_at_submission_details.txt"}
      allow(controller).to receive(:current_vendor).and_return(@vendor)
      allow(@vendor).to receive(:import).and_return(@err_hash)
      allow(controller).to receive(:validation_errors_content).with(@err_hash).and_return(content)
      expect(controller).to receive(:send_data).with(content, file) {controller.render nothing: true}
      post :import, file: !nil
    end  
  end
end