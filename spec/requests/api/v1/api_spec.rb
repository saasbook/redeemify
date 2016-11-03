require 'rails_helper'

describe 'Codes', type: :request do
  it 'returns a list of vendor links for a given code' do
    get '/codes/xzczxvz'

    expect(response).to be_success
  end
end