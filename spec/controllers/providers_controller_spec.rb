require 'spec_helper'
require 'rails_helper'

describe ProvidersController do
  describe "#home" do
    render_views
    
    it "renders the about template" do

      expect(session[:provider_id]).to be_nil

      v = Provider.create :name => "thai" , :provider => "amazon"
      v.history = "+++++April 3rd, 2015 23:51+++++Code Description+++++05/02/2015+++++2|||||"
      v.save!

      session[:provider_id] = v.id

      expect(session[:provider_id]).not_to be_nil

      get 'upload_page'
      expect(response).to render_template :upload_page
    end
    
    it "renders the home page with the provider name" do
      google = FactoryGirl.create(:provider)
      allow(controller).to receive(:current_provider).and_return(google)
      get :home
      expect(response).to render_template(:home)
      expect(response.body).to match(/Google Oauth/)
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

    it "renders the upload page with the provider name" do
      google = FactoryGirl.create(:provider)
      allow(controller).to receive(:current_provider).and_return(google)
      get :upload_page
      expect(response).to render_template(:upload_page)
      expect(response.body).to match(/Google Oauth/)
    end
  end
  
  describe "#import2" do
    render_views
    before do
      @hash = {err_codes: 0, submitted_codes: 5}
      @err_hash = {err_codes: 2, submitted_codes: 5}
    end  

    it "renders the upload page and notifies user when no file is picked to upload" do
      post :import2
      expect(response).to redirect_to(:providers_upload_page)
      expect(flash[:error]).to eq("You have not selected a file to upload")
    end
    
    it "redirects to the home page and notifies user of codes successfully uploaded" do
      allow(Vendor).to receive(:import).and_return(@hash)
      post :import2, file: !nil
      expect(response).to redirect_to(:providers_home)
      expect(flash[:notice]).to match(/5 codes imported/)
    end
    
    it "calls #validation_errors_content to generate report content" do
      allow(Vendor).to receive(:import).and_return(@err_hash)
      expect(controller).to receive(:validation_errors_content).with(@err_hash)
      post :import2, file: !nil
    end  

    it "calls #send_data prompting user to download error report" do
      
      content = "N codes submitted to update the code set"
      file = {filename: "#{@err_hash[:err_codes]}_codes_rejected_at_submission_details.txt"}
      allow(Vendor).to receive(:import).and_return(@err_hash)
      allow(controller).to receive(:validation_errors_content).with(@err_hash).and_return(content)
      expect(controller).to receive(:send_data).with(content, file) {controller.render nothing: true}
      post :import2, file: !nil
    end  
  end
end