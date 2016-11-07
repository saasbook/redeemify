class UsersController < ApplicationController

  before_action :set_code, only: [:show]

  def show  
    render json: @code
  end

  def set_code  
    #@code = RedeemifyCode.find_by(code: params[:code])
    @code = VendorCode.find_by(redeemify_code: params[:code])
  end

  def code_params
    #ActiveModelSerializers::Deserialization.jsonapi_parse(params)
    #params.require(:code) #.permit(:cd)
  end
end
