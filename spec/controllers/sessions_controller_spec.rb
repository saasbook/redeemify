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
      user = create(:user, code: '12345')
      allow(controller).to receive(:current_user).and_return(user)
      get :customer
      expect(response).to render_template :customer
    end
  end

  describe "#delete_account" do
    before do
      post :create, provider: :amazon
    end
    it "it should call the user#anonymize! method" do
        expect_any_instance_of(User).to receive(:anonymize!).with(no_args)
        allow(RedeemifyCode).to receive(:anonymize!).with(any_args)
        allow(VendorCode).to receive(:anonymize_all!).with(any_args)
        get 'delete_account'
    end
    it "it should call the RedeemifyCode.anonymize! method" do
        allow_any_instance_of(User).to receive(:anonymize!).with(no_args)
        expect(RedeemifyCode).to receive(:anonymize!).with(any_args)
        allow(VendorCode).to receive(:anonymize_all!).with(any_args)
        get 'delete_account'
    end
    it "it should call the VendorCode.anonymize_all! method" do
        allow_any_instance_of(User).to receive(:anonymize!).with(no_args)
        allow(RedeemifyCode).to receive(:anonymize!).with(any_args)
        expect(VendorCode).to receive(:anonymize_all!).with(any_args)
        get 'delete_account'
    end
    it "should clear the session" do
        allow_any_instance_of(User).to receive(:anonymize!).with(no_args)
        allow(RedeemifyCode).to receive(:anonymize!).with(any_args)
        allow(VendorCode).to receive(:anonymize_all!).with(any_args)
        
        get 'delete_account'
        expect(session[:user_id]).to be_nil
    end
    it "should redirect to the root template, notify user of the account deletion" do
        allow_any_instance_of(User).to receive(:anonymize!).with(no_args)
        allow(RedeemifyCode).to receive(:anonymize!).with(any_args)
        allow(VendorCode).to receive(:anonymize_all!).with(any_args)

        get 'delete_account'
        expect(response).to redirect_to root_url
        expect(flash[:notice]).to eq("Your account has been deleted")
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
