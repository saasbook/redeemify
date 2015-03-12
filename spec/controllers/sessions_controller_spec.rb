require 'spec_helper'
require 'rails_helper'

 
describe SessionsController do

 
  before do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:amazon]
  end

  describe "#new" do
     it "renders the about template" do
        get 'new' # or :new
        expect(response).to render_template :new
    end
  end
 
  describe "#create" do
 
    it "should successfully create a user" do
      expect {
        post :create, provider: :amazon
      }.to change{ User.count }.by(1)
    end
 
    it "should successfully create a session" do
      session[:user_id].should be_nil
      post :create, provider: :amazon
      session[:user_id].should_not be_nil
    end
 
    it "should redirect the user to the root url/new page" do
      post :create, provider: :amazon
      response.should redirect_to '/sessions/new'
    end
  end

  describe "#destroy" do
    before do
      post :create, provider: :amazon
    end

    it "should clear the session" do

      session[:user_id].should_not be_nil
      delete :destroy
      session[:user_id].should be_nil
    end
 
    it "should redirect to the new page" do
      delete :destroy
      response.should redirect_to root_url
    end
  end
 
end