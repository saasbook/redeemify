require 'spec_helper'
require 'rails_helper'

describe ProvidersController do
  describe "GET #home" do
    render_views
    
    it "renders the home template" do
      expect(session[:provider_id]).to be_nil
      p = Provider.create :name => "thai" , :provider => "amazon"
      p.history = "April 3rd, 2015 23:51\tAction description\t30\n"
      p.save!
      session[:provider_id] = p.id
      expect(session[:provider_id]).not_to be_nil
    end
    
    it "renders the home page with the provider name" do
      google = FactoryGirl.create(:provider)
      allow(controller).to receive(:current_provider).and_return(google)
      get :home
      expect(response).to render_template(:home)
      expect(response.body).to match(/Google/)
    end
  end

  describe "GET #edit" do
    it "renders the edit template" do
      provider = create(:provider)
      allow(controller).to receive(:current_provider).and_return(provider)
      get :edit
      expect(response).to render_template :edit
    end
  end

  describe "GET #index" do
    it "renders the index template" do
      provider = create(:provider)
      allow(controller).to receive(:current_provider).and_return(provider)
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #upload_page" do
    render_views
    
    it "renders the upload page with the provider name" do
      google = FactoryGirl.create(:provider)
      allow(controller).to receive(:current_provider).and_return(google)
      get :upload_page
      expect(response).to render_template(:upload_page)
      expect(response.body).to match(/Google/)
    end
  end
  
  describe "POST #import" do
    render_views
    
    before do
      @provider = create(:provider)
      allow(controller).to receive(:current_provider).and_return(@provider)
      @hash = {err_codes: 0, submitted_codes: 5}
      @err_hash = {err_codes: 2, submitted_codes: 5}
    end  

    it "renders the upload page and notifies user when no file is picked to upload" do
      post :import
      expect(response).to redirect_to(:providers_upload_page)
      expect(flash[:error]).to eq("You have not selected a file to upload")
    end
    
    it "redirects to the home page and notifies user of codes successfully uploaded" do
      allow(@provider).to receive(:import).and_return(@hash)
      post :import, file: !nil
      expect(response).to redirect_to(:providers_home)
      expect(flash[:notice]).to match(/5 codes imported/)
    end
    
    it "calls #validation_errors_content to generate report content" do
      allow(@provider).to receive(:import).and_return(@err_hash)
      expect(controller).to receive(:validation_errors_content).with(@err_hash)
      post :import, file: !nil
    end  

    it "calls #send_data prompting user to download error report" do
      content = "N codes submitted to update the code set"
      file = {filename: "#{@err_hash[:err_codes]}_codes_rejected_at_submission_details.txt"}
      allow(@provider).to receive(:import).and_return(@err_hash)
      allow(controller).to receive(:validation_errors_content).with(@err_hash).and_return(content)
      expect(controller).to receive(:send_data).with(content, file) {controller.render nothing: true}
      post :import, file: !nil
    end
  end
  
  describe "GET #remove_unclaimed_codes" do
    before do
      @provider = create(:provider)
    end
    it "displays the error message when there are no unclaimed codes" do
      @provider.unclaimCodes = 0
      allow(controller).to receive(:current_provider).and_return(@provider)
      get :remove_unclaimed_codes
      expect(response).to redirect_to(:providers_home)
      expect(flash[:error]).to eq("There are no unclaimed codes")
    end
    it "removes unclaimed codes" do
      create_list(:redeemify_code, 5, provider_id: @provider.id)
      @provider.unclaimCodes = 5
      expect(@provider.redeemifyCodes.count).to eq(5)
      expect(@provider.unclaimCodes).to eq(5)
      allow(controller).to receive(:current_provider).and_return(@provider)
      get :remove_unclaimed_codes
      expect(@provider.redeemifyCodes.count).to eq(0)
      expect(@provider.unclaimCodes).to eq(0)
      expect(response).to redirect_to(:providers_home)
      expect(flash[:notice]).to eq("Codes were removed")
    end
  end
  
  describe "GET #download_unclaimed_codes" do
    before do
      @provider = create(:provider)
      create_list(:redeemify_code, 5, provider_id: @provider.id)
    end
    it "downloads unclaimed codes" do
      unclaimed_codes = "unclaimed codes"
      file = {filename: "unclaimed_codes.txt"}
      allow(controller).to receive(:current_provider).and_return(@provider)
      allow(@provider).to receive(:download_unclaimed_codes).
        and_return(unclaimed_codes)
      expect(controller).to receive(:send_data).
        with(unclaimed_codes, file) {controller.render nothing: true}
      get :download_unclaimed_codes
    end
  end
  
  describe "GET #view_codes" do
    before do
      @provider = create(:provider)
    end
    it "renders view_codes template" do
      allow(controller).to receive(:current_provider).and_return(@provider)
      get :view_codes
      expect(response).to render_template(:view_codes)
    end
  end
  
  describe "GET #clear_history" do
    before do
      @provider = create(:provider)
    end
    it "displays the error message when history is empty" do
      @provider.history = nil
      allow(controller).to receive(:current_provider).and_return(@provider)
      get :clear_history
      expect(response).to redirect_to(:providers_home)
      expect(flash[:error]).to eq("History is empty")
    end
    it "clears history" do
      expect(@provider.history).to eq("History")
      allow(controller).to receive(:current_provider).and_return(@provider)
      get :clear_history
      expect(@provider.history).to be_nil
      expect(response).to redirect_to(:providers_home)
      expect(flash[:notice]).to eq("History was cleared")
    end
  end
end

