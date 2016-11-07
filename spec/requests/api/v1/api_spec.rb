require 'rails_helper'
require 'spec_helper'

RSpec.describe "Redeemify API", type: :request do
  describe "GET /users/:user_id/redeemify_codes/:id" do
    it "returns the bundled codes" do
      #vendor = FactoryGirl.create :vendor, name: 'Vendor1'
      @rcode  = FactoryGirl.create :redeemify_code, code: '1234'
      @vcode  = FactoryGirl.create :vendor_code, code: 'asdf'
      @user   = FactoryGirl.create :user, name: "Joe"

      #get '/user', params: { since: 201501011400 }
      get :show, @user.id, @rcode.id
      get '/users/:user_id/redeemifycodes/:id', params: {user_id: @user.id, id: @rcode.id }
      #post "/login", params: { username: users(:david).username, password: users(:david).password }
      expect(response).to have_http_status(200)
       
      body = JSON.parse(response.body)
       code_value = body['code'] #['data']['attributes']['code']
       expect(code_value) == 'asdf'
    end
  end
end
