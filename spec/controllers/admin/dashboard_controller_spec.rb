require 'rails_helper'

describe Admin::DashboardController do
  include Devise::Test::ControllerHelpers
  render_views
  
  before do
    admin = create(:admin_user)
    sign_in(admin)
  end
  
  describe "GET #index" do
    it "renders index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end
end