require 'spec_helper'
require 'rails_helper'
 
describe VendorsController do

  describe "GET #home" do
    render_views
  
    it "renders profile, upload_page and view_codes templates" do
      expect(session[:vendor_id]).to be_nil
      v = Vendor.create :name => "thai" , :uid => "54321", :provider => "amazon"
      v.history = "April 3rd, 2015 23:51\tComment\t5\n"
      v.save!
      session[:vendor_id] = v.id
      expect(session[:vendor_id]).not_to be_nil
      get 'profile'
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
      expect(response.body).to match(/amazon_oauth2/i)
    end
  end

  describe "GET #edit" do
    it "renders edit template" do
      vendor = create(:vendor)
      allow(controller).to receive(:current_vendor).and_return(vendor)
      get :edit
      expect(response).to render_template :edit
    end
  end

  describe "GET #index" do
    it "renders index template" do
      vendor = create(:vendor)
      allow(controller).to receive(:current_vendor).and_return(vendor)
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #upload_page" do
    render_views
    it "renders the upload page with the vendor provider" do
      amazon = FactoryGirl.create(:vendor)
      allow(controller).to receive(:current_vendor).and_return(amazon)
      get :upload_page
      expect(response).to render_template(:upload_page)
      expect(response.body).to match(/amazon_oauth2/i)
    end
  end
  
  describe "GET #profile" do
    render_views
    it "renders the profile page" do
      amazon = FactoryGirl.create(:vendor)
      allow(controller).to receive(:current_vendor).and_return(amazon)
      get :profile
      expect(response).to render_template(:profile)
      
      expect(response.body).to match("01/27/2015")
      expect(response.body).to match("AWS credit")
      expect(response.body).to match("https://aws.amazon.com/uk/awscredits/")
      expect(response.body).to match("Follow the page and redeem credit")
    end
  end

  describe "POST #import" do
    render_views
    before do
      @vendor = create(:vendor)
      allow(controller).to receive(:current_vendor).and_return(@vendor)
      @hash = {err_codes: 0, submitted_codes: 5}
      @err_hash = {err_codes: 2, submitted_codes: 5}
    end  

    it "renders the upload page and notifies user when no file is picked to upload" do
      post :import
      expect(response).to redirect_to(:vendors_upload_page)
      expect(flash[:error]).to eq("You have not selected a file to upload")
    end
    
    it "redirects to the home page and notifies user of codes successfully uploaded" do
      allow(@vendor).to receive(:import).and_return(@hash)
      post :import, file: !nil
      expect(response).to redirect_to(:vendors_home)
      expect(flash[:notice]).to match(/5 codes imported/)
    end
    
    it "calls #validation_errors_content to generate report content" do
      allow(@vendor).to receive(:import).and_return(@err_hash)
      expect(controller).to receive(:validation_errors_content).with(@err_hash)
      post :import, file: !nil
    end  

    it "calls #send_data prompting user to download error report" do
      content = "N codes submitted to update the code set"
      file = {filename: "#{@err_hash[:err_codes]}_codes_rejected_at_submission_details.txt"}
      allow(@vendor).to receive(:import).and_return(@err_hash)
      allow(controller).to receive(:validation_errors_content).with(@err_hash).and_return(content)
      expect(controller).to receive(:send_data).with(content, file) {controller.render nothing: true}
      post :import, file: !nil
    end  
  end
  
  describe "POST #update_profile" do
    before do
      @vendor = create(:vendor)
    end
    it "updates vendor profile" do
      expect(@vendor.cashValue).to eq("$10")
      allow(controller).to receive(:current_vendor).and_return(@vendor)
      post :update_profile, cash_value: "$15"
      expect(@vendor.cashValue).to eq("$15")
      expect(response).to redirect_to(:vendors_home)
      expect(flash[:notice]).to eq("Profile updated")
    end
  end
  
  describe "GET #remove_unclaimed_codes" do
    before do
      @vendor = create(:vendor)
    end
    it "displays the error message when there are no unclaimed codes" do
      @vendor.unclaimCodes = 0
      allow(controller).to receive(:current_vendor).and_return(@vendor)
      get :remove_unclaimed_codes
      expect(response).to redirect_to(:vendors_home)
      expect(flash[:error]).to eq("There are no unclaimed codes")
    end
    it "removes unclaimed codes" do
      create_list(:vendor_code, 5, vendor_id: @vendor.id)
      @vendor.unclaimCodes = 5
      expect(@vendor.vendorCodes.count).to eq(5)
      expect(@vendor.unclaimCodes).to eq(5)
      allow(controller).to receive(:current_vendor).and_return(@vendor)
      get :remove_unclaimed_codes
      expect(@vendor.vendorCodes.count).to eq(0)
      expect(@vendor.unclaimCodes).to eq(0)
      expect(response).to redirect_to(:vendors_home)
      expect(flash[:notice]).to eq("Codes were removed")
    end
  end
  
  describe "GET #download_unclaimed_codes" do
    before do
      @vendor = create(:vendor)
      create_list(:vendor_code, 5, vendor_id: @vendor.id)
    end
    it "downloads unclaimed codes" do
      unclaimed_codes = "unclaimed_codes"
      file = {filename: "unclaimed_codes.txt"}
      allow(controller).to receive(:current_vendor).and_return(@vendor)
      allow(@vendor).to receive(:download_unclaimed_codes).
        and_return(unclaimed_codes)
      expect(controller).to receive(:send_data).
        with(unclaimed_codes, file) {controller.render nothing: true}
      get :download_unclaimed_codes
    end
  end
  
  describe "GET #view_codes" do
    before do
      @vendor = create(:vendor)
    end
    it "renders view_codes template" do
      allow(controller).to receive(:current_vendor).and_return(@vendor)
      get :view_codes
      expect(response).to render_template(:view_codes)
    end
  end
  
  describe "GET #clear_history" do
    before do
      @vendor = create(:vendor)
    end
    it "displays the error message when history is empty" do
      @vendor.history = nil
      allow(controller).to receive(:current_vendor).and_return(@vendor)
      get :clear_history
      expect(response).to redirect_to(:vendors_home)
      expect(flash[:error]).to eq("History is empty")
    end
    it "clears history" do
      expect(@vendor.history).to eq("History")
      allow(controller).to receive(:current_vendor).and_return(@vendor)
      get :clear_history
      expect(@vendor.history).to be_nil
      expect(response).to redirect_to(:vendors_home)
      expect(flash[:notice]).to eq("History was cleared")
    end
  end
  
  describe "GET #change_to_user" do
    before do
      @vendor = create(:vendor)
    end
    it "redirects to new session page when redeemify code is not presented" do
      allow(controller).to receive(:current_vendor).and_return(@vendor)
      get :change_to_user
      expect(response).to redirect_to('/sessions/new')
      expect(flash[:notice]).to eq("Changed to user account")
    end
    it "redirects to customer's page when user has redeemify code" do
      user = create(:user, code: "12345")
      allow(controller).to receive(:current_vendor).and_return(user)
      get :change_to_user
      expect(response).to redirect_to('/sessions/customer')
    end
  end
end