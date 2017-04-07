require 'rails_helper'

describe Admin::ProvidersController do
  include Devise::Test::ControllerHelpers
  render_views
  
  before do
    @admin = create(:admin_user)
    @provider = create(:provider)
    sign_in(@admin)
  end
  
  describe "GET #index" do
    it "shows all providers" do
      get :index
      expect(response).to render_template(:index)
      expect(response.body).to have_content("example@google.com")
    end
  end
  
  describe "GET #edit" do
    it "renders edit template" do
      get :edit, id: @provider
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH #update" do
    it "changes provider details" do
      patch :update, id: @provider, provider: attributes_for(:provider,
        email: "test@google.com")
      @provider.reload
      expect(@provider.email).to eq("test@google.com")
    end
  end
  
  describe "POST #create" do
    it "creates new provider" do
      expect{ post :create, provider: { name: "AgileVentures",
        provider: "github_oauth2", email: "admin@agileventures.org" } }.
          to change{ Provider.count }.by(1)
    end
  end
  
  describe "DELETE #destroy" do
    it "removes provider" do
      expect{ delete :destroy, id: @provider }.
        to change{ Provider.count }.by(-1)
    end
  end
end