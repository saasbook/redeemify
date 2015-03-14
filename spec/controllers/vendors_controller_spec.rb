require 'spec_helper'
require 'rails_helper'

 
describe VendorsController do
  describe "#home" do
     it "renders the about template" do

      session[:vendor_id].should be_nil

      v = Vendor.create :name => "thai" , :uid => "54321", :provider => "amazon"
      v.save!

      session[:vendor_id] = v.id
      session[:vendor_id].should_not be_nil
      get 'home' # or :new
      expect(response).to render_template :home
    end
  end

  describe "#edit" do
     it "renders the about template" do
        get :edit
        expect(response).to render_template :edit
    end
  end

  describe "#index" do
     it "renders the about template" do
        get 'index' # or :new
        expect(response).to render_template :index
    end
  end


   describe "#destroy" do
    it "login and put into the session" do
      session[:vendor_id].should be_nil

      v = Vendor.create :name => "thai" , :uid => "54321", :provider => "amazon"
      v.save!

      session[:vendor_id] = v.id
      session[:vendor_id].should_not be_nil
    end


    it "should clear the session" do
      session[:vendor_id].should be_nil

      v = Vendor.create :name => "thai" , :uid => "54321", :provider => "amazon"
      v.save!

      session[:vendor_id] = v.id
      session[:vendor_id].should_not be_nil
      delete :destroy
      flash[:notice].should == "Signed out!"
      session[:vendor_id].should be_nil
      response.should redirect_to root_url
    end
 

  end

end