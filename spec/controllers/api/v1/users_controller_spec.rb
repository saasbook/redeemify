require 'spec_helper'

describe Api::V1::UsersController, :type => :controller do

  describe "GET #show" do
    before(:each) do
      @user = FactoryGirl.create :user
      get :show, id: @user.id
    end
    
    it "returns information about requester" do
      user_response = json_response
      expect(user_response[:email]).to eql @user.email
    end
    
    it "returns success" do
      expect(response).to have_http_status(200)
    end
  end
  
  describe "POST #create" do
    
    context "when is successfully created" do
      before(:each) do
        @user_attributes = FactoryGirl.attributes_for :user
        post :create, { user: @user_attributes }
      end
      
      it "renders json representation of the created user" do
        user_response = json_response
        expect(user_response[:email]).to eql @user_attributes[:email]
      end
      
      it "returns 201" do
        expect(response).to have_http_status(201)
      end
    end
    
    # Task: strengthen the validations for the user
    context "when is not created" do
      before(:each) do
        @invalid_user_attributes = { email: "example@domain.com", name: "user" }
        post :create, { user: @invalid_user_attributes }
      end
      
      it "renders json with errors" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end
      
      it "renders json with errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:uid]).to include "can't be blank"
      end
      
      it "returns 422" do
        expect(response).to have_http_status(422)
      end
    end
    
  end
  
  describe "PUT/PATCH #update" do
    
    context "when is successfully updated" do
      before(:each) do
        @user = FactoryGirl.create :user
        patch :update, { id: @user.id,
                         user: { email: "new@domain.com" } }
      end
      
      it "renders json representation of the updated user" do
        user_response = json_response
        expect(user_response[:email]).to eql "new@domain.com"
      end
      
      it "returns success" do
        expect(response).to have_http_status(200)
      end
    end
    
    context "when is not updated" do
      before(:each) do
        @user = FactoryGirl.create :user
        patch :update, { id: @user.id,
                         user: { email: "wrong@mail" } }
      end
      
      it "renders json with errors" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end
      
      it "renders json with errors on why the user could not be updated" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end
      
      it "returns 422" do
        expect(response).to have_http_status(422)
      end
    end
  end
  
  describe "DELETE #destroy" do
    before(:each) do
      @user = FactoryGirl.create :user
      delete :destroy, { id: @user.id }
    end
    
    it "returns 204" do
      expect(response).to have_http_status(204)
    end
  end

end