require 'spec_helper'
require 'rails_helper'
 
describe VendorsController do

  describe "#home" do
    render_views  
    it "renders the about template" do
      expect(session[:vendor_id]).to be_nil

      v = Vendor.create :name => "thai" , :uid => "54321", :provider => "amazon"
      v.history = "+++++April 3rd, 2015 23:51+++++Code Description+++++05/02/2015+++++2|||||"
      v.save!

      session[:vendor_id] = v.id
      expect(session[:vendor_id]).not_to be_nil
      get 'profile' # or :new
      expect(response).to render_template :profile

      get 'upload_page'
      expect(response).to render_template :upload_page

      get 'viewCodes'
      expect(response).to render_template :viewCodes
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

end