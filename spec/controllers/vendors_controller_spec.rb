require 'spec_helper'
require 'rails_helper'
 
describe VendorsController do

  describe "#home" do
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