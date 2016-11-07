require 'rails_helper'
require 'spec_helper'

RSpec.describe "Redeemify API", type: :request do
  describe "GET /users/:user_id/redeemify_codes/:id" do
    it "returns the bundled codes" do
      FactoryGirl.create :redeemify_code, code: '1234'
      FactoryGirl.create :vendor_code, code: 'asdf'
      get '/codes/1234'
      expect(response).to have_http_status(200)
       
      body = JSON.parse(response.body)
       code_value = body['code'] #['data']['attributes']['code']
       expect(code_value) == 'asdf'
    end
  end
end
