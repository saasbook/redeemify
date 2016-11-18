require 'rails_helper'
require 'spec_helper'

RSpec.describe Api::V1::UsersController do
  describe "GET /users/:id" do

    subject(:make_get_request) { get :show, id: @user.id }

    before do
      @user   = FactoryGirl.create :user, name: 'Joe'
      @rcode  = FactoryGirl.create :redeemify_code, { code: '1234', user_id: @user.id }
      @vcode  = FactoryGirl.create :vendor_code, { code: 'asdf', user_id: @user.id }

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    it "returns success" do
      make_get_request
      expect(response).to have_http_status(200)
    end

    it "returns the bundled codes" do
      make_get_request
      body = JSON.parse(response.body)
      code_value = body['code']
      expect(code_value) == 'asdf'
    end
  end
end