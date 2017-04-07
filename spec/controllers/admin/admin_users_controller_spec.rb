require 'rails_helper'

describe Admin::AdminUsersController do
  include Devise::Test::ControllerHelpers
  render_views
  
  before do
    @admin = create(:admin_user)
    sign_in(@admin)
  end
  
  describe "GET #index" do
    it "shows all administrators" do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to have_content("admin@redeemify.com")
    end
  end
  
  describe "GET #show" do
    it "shows admin details" do
      get :show, id: @admin
      expect(response).to render_template(:show)
      expect(response.body).to have_content("admin@redeemify.com")
    end
  end
  
  describe "GET #edit" do
    it "renders edit templater" do
      get :edit, id: @admin
      expect(response).to render_template(:edit)
    end
  end
  
  describe "PATCH #update" do
    it "changes admin details" do
      patch :update, id: @admin, admin_user: attributes_for(:admin_user,
        email: "admin@strawberrycanyon.com")
      @admin.reload
      expect(@admin.email).to eq("admin@strawberrycanyon.com")
    end
  end
  
  describe "GET #new" do
    it "renders new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end
  
  describe "POST #create" do
    it "creates new admin" do
      expect{ post :create, admin_user: { email: "admin@strawberrycanyon.com",
        password: "password" } }.to change{ AdminUser.count }.by(1)
    end
  end
  
  describe "DELETE #destroy" do
    it "removes admin" do
      expect{ delete :destroy, id: @admin }.to change{ AdminUser.count }.by(-1)
    end
  end
end