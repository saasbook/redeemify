require 'rubygems'
require 'google_chart'

class VendorsController < ApplicationController

  def index
    # @vendor = Vendor.find(session[:vendor_id])
  end
# --------------------------
  def import
    if params[:file].nil?
      redirect_to '/vendors/upload_page', :flash => { :error => "You have not upload a file" }
    else
      Vendor.import(params[:file], current_vendor, params[:comment], "vendor")
      redirect_to '/vendors/home', notice: "Codes imported"
    end
  end


# ---------------
  def home

    @histories_array = []
    if current_vendor.history != nil
      @histories_array = Vendor.homeSet(current_vendor.history)
    end

    @hash = {"uploaded" => current_vendor.uploadedCodes,"used" => current_vendor.usedCodes, "unclaim" => current_vendor.unclaimCodes, "removed" => current_vendor.removedCodes }
    gon.codes = @hash
    gon.history = current_vendor.history

  end


  def upload_page
    @vendorcodes= current_vendor.vendorCodes.all
  end


  def profile
    @vendorcodes = current_vendor.vendorCodes.all
  end

  def update_profile

    @info = {}
    cash = params[:cashValue]
    cash = cash.gsub(/\s+/, "")
    @info["cashValue"] = cash

    @info["instruction"] = params[:instruction]
    @info["description"] = params[:description]
    @info["helpLink"] = params[:helpLink]
    @info["expiration"] = params[:expiration]

    Vendor.update_profile_vendor(current_vendor,@info)
    redirect_to '/vendors/home', notice: "Profile Updated"
  end

  def remove_codes   #:usedCodes, :uploadedCodes, :totalCodes, :unclaimCodes, :removedCodes
    flag = current_vendor.vendorCodes.where(:user_id => nil)
    if flag.count == 0
      redirect_to '/vendors/home', :flash => { :error => "There's No Unclaimed Codes" }
    else
      contents = Vendor.remove_unclaimed_codes(current_vendor,"vendor")
      send_data contents,  :filename => "Unclaimed_Codes.txt" 
    end
  end


  def clear_history
    if current_vendor.history.nil?
      redirect_to '/vendors/home', :flash => { :error => "History is empty" }
    else  
      current_vendor.update_attribute(:history, nil)
      redirect_to '/vendors/home', notice: "Cleared History"
    end
  end

  def change_to_user
    current_user=User.find_by_provider_and_email(current_vendor.provider, current_vendor.email)
    if current_user.nil?
     current_user =  User.create!(:provider => current_vendor.provider, :name => current_vendor.name, :email => current_vendor.email)
    end
    session[:user_id]=current_user.id
    if current_user.code == nil 
      redirect_to '/sessions/new', notice: "Changed to user account"
    else
      redirect_to '/sessions/customer', notice: "Changed to user account"
    end
  end



end
