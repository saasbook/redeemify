require 'rubygems'
require 'google_chart'

class VendorsController < ApplicationController
  include OfferorActions
  before_action :require_login

  def index
  end

  def profile
  end
  
  def update_profile
    @info = {}
    cash = params[:cash_value]
    cash = cash.gsub(/\s+/, "")
    @info["cashValue"] = cash
    @info["instruction"] = params[:instruction]
    @info["description"] = params[:description]
    @info["helpLink"] = params[:help_link]
    @info["expiration"] = params[:expiration]
    Vendor.update_profile_vendor(current_vendor, @info)
    redirect_to '/vendors/home', notice: "Profile updated"
  end

  def change_to_user
    current_user = User.find_by_provider_and_email(current_vendor.provider,
                    current_vendor.email)
    if current_user.nil?
      current_user =  User.create!(provider: current_vendor.provider,
        uid: current_vendor.uid, name: current_vendor.name, email: current_vendor.email)
    end
    session[:user_id] = current_user.id
    if current_user.code.nil?
      redirect_to '/sessions/new', notice: "Changed to user account"
    else
      redirect_to '/sessions/customer'
    end
  end
end
