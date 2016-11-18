class UsersController < ApplicationController

  # This method is here temporarily so that the cucumber api_get.feature passes
  # both when running cucumber and on the CI environment.
  # Otherwise we would need somthing like 'prax' running.
  def index
    render json: {
         code: '12345'
    }.to_json
  end
end
