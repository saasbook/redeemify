require 'spec_helper'
require 'rails_helper'

 
describe SessionsController do

 
  before :each do
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:amazon]
  end



  describe "#new" do
     it "renders the about template" do
        get 'new' # or :new
        expect(response).to render_template :new
    end
  end



  describe "#show" do
    before do
      post :create, provider: :amazon
      flash[:notice].should == "Signed in!"
    end

    it "renders the about template" do
        get 'failure'
        get 'new' # or :new
        expect(response).to render_template :new
    end

     it "renders the about template" do
        get 'offer'
        get :show # or :new
        expect(response).to render_template :show
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
      get 'offer'
      flash[:notice].should == "Signed in!"
      session[:user_id].should_not be_nil

      # session[:user_id].should == 

    end

    it "renders the about template" do
        get 'new' # or :new
        expect(response).to render_template :new
    end

    it "should redirect the user to the root url/new page" do
      post :create, provider: :amazon
      flash[:notice].should == "Signed in!"
      response.should redirect_to '/sessions/new'
    end
  end

  describe "#Offer" do
    it "should redirect the user to the offer page" do
      # post :create, provider: :github
      # session[:user_id].should_not be_nil
      # # v = User.create :name => "thai" , :code => "123", :uid => "54321", :provider => "amazon"
      # # v.save!
      # # post :create, provider:
      get :offer
      expect(response).to render_template :offer
    end
  end
  

  describe "#destroy" do
    before do
      post :create, provider: :amazon
    end

    it "renders the about template" do
        get 'new' # or :new
        expect(response).to render_template :new
    end

     it "renders the about template" do
        get :show # or :new
        expect(response).to render_template :show
    end

    it "should clear the session" do
      session[:user_id].should_not be_nil
      delete :destroy
      flash[:notice].should == "Signed out!"
      session[:user_id].should be_nil
    end
 
    it "should redirect to the new page" do
      delete :destroy
      flash[:notice].should == "Signed out!"
      response.should redirect_to root_url
    end
  end



 
end