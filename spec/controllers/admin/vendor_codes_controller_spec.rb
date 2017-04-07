require 'rails_helper'

describe Admin::VendorCodesController do
  include Devise::Test::ControllerHelpers
  render_views
  
  before do
    @admin = create(:admin_user)
    @vendor_code = VendorCode.create!(code: "0001")
    sign_in(@admin)
  end
  
  describe "GET #index" do
    it "shows all vendor codes" do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to have_content("0001")
    end
  end
  
  describe "GET #show" do
    it "shows vendor code details" do
      get :show, id: @vendor_code
      expect(response).to render_template(:show)
      expect(response.body).to have_content("0001")
    end
  end
  
  describe "DELETE #destroy" do
    it "removes vendor code" do
      expect{ delete :destroy, id: @vendor_code }.
        to change{ VendorCode.count }.by(-1)
    end
  end
end