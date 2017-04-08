require 'rails_helper'

describe Admin::RedeemifyCodesController do
  include Devise::Test::ControllerHelpers
  render_views
  
  before do
    @admin = create(:admin_user)
    @redeemify_code = RedeemifyCode.create!(code: "0001")
    sign_in(@admin)
  end
  
  describe "GET #index" do
    it "shows all redeemiy codes" do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to have_content("0001")
    end
  end
  
  describe "GET #show" do
    it "shows redeemify code details" do
      get :show, id: @redeemify_code
      expect(response).to render_template(:show)
      expect(response.body).to have_content("0001")
    end
  end
  
  describe "DELETE #destroy" do
    it "removes redeemify code" do
      expect{ delete :destroy, id: @redeemify_code }.
        to change{ RedeemifyCode.count }.by(-1)
    end
  end
end