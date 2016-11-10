require 'spec_helper'
require 'rails_helper'

describe ProvidersController do
  describe "#home" do
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

end