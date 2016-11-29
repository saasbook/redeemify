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
end
