require 'rails_helper'

describe Admin::UsersController do
  include Devise::Test::ControllerHelpers
  render_views
  
  before do
    @admin = create(:admin_user)
    @user = create(:user)
    sign_in(@admin)
  end
  
  describe "GET #index" do
    it "shows all users" do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to have_content("user@google.com")
    end
  end
  
  describe "GET #show" do
    it "shows user details" do
      get :show, id: @user
      expect(response).to render_template(:show)
      expect(response.body).to have_content("user@google.com")
    end
  end
  
  describe "DELETE #destroy" do
    it "removes user" do
      expect{ delete :destroy, id: @user }.to change{ User.count }.by(-1)
    end
  end
end