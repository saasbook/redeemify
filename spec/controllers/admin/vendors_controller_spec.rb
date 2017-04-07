require 'rails_helper'

describe Admin::VendorsController do
  include Devise::Test::ControllerHelpers
  render_views
  
  before do
    @admin = create(:admin_user)
    @vendor = create(:vendor)
    sign_in(@admin)
  end
  
  describe "GET #index" do
    it "shows all vendors" do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to have_content("example@amazon.com")
    end
  end
  
  describe "GET #edit" do
    it "renders edit template" do
      get :edit, id: @vendor
      expect(response).to render_template(:edit)
    end
  end
  
  describe "PATCH #update" do
    it "changes vendor details" do
      patch :update, id: @vendor, vendor: attributes_for(:vendor,
        email: "test@amazon.com")
      @vendor.reload
      expect(@vendor.email).to eq("test@amazon.com")
    end
  end
  
  describe "POST #create" do
    it "creates new vendor" do
      expect{ post :create, vendor: { name: "AgileVentures",
        provider: "github_oauth2", uid: "uid", email: "admin@agileventures.org",
        description: "Premium for 1 month" } }.to change{ Vendor.count }.by(1)
    end
  end
  
  describe "DELETE #destroy" do
    it "removes vendor" do
      expect{ delete :destroy, id: @vendor }.to change{ Vendor.count }.by(-1)
    end
  end
end