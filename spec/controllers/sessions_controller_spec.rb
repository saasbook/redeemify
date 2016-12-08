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
      expect(flash[:notice]).to eq("Signed in!")
    end

    it "renders the about template" do
        get 'failure'
        get 'new' # or :new
        expect(response).to render_template :new
    end

     it "renders the about template" do
        get 'customer'
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
      expect(session[:user_id]).to be_nil
      post :create, provider: :amazon
      get 'customer'
      # flash[:notice].should == "Signed in!"
      flash[:notice].include?("wrong")
      expect(session[:user_id]).not_to be_nil

      # session[:user_id].should ==
    end

    it "renders the about template" do
        get 'new' # or :new
        expect(response).to render_template :new
    end

    it "should redirect the user to the root url/new page" do
      post :create, provider: :amazon
      expect(flash[:notice]).to eq("Signed in!")
      expect(response).to redirect_to '/sessions/new'
    end
  end


  describe "#customer" do
    it "should redirect the user to the customer page" do
      v = Vendor.create! :name => "thai" , :uid => "54321", :provider => "amazon"
      v.history = "+++++April 3rd, 2015 23:51+++++Code Description+++++05/02/2015+++++2|||||"
      v.save!

      a = v.vendorCodes.create!(:code => "123", :vendor => v)
      a.save!
      get :customer
      expect(response).to render_template :customer
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
      expect(session[:user_id]).not_to be_nil
      delete :destroy
      expect(flash[:notice]).to eq("Signed out!")
      expect(session[:user_id]).to be_nil
    end

    it "should redirect to the new page" do
      delete :destroy
      expect(flash[:notice]).to eq("Signed out!")
      expect(response).to redirect_to root_url
    end
  end

end
