class VendorsController < ApplicationController
  def new
    # @vendor = Vendor.new
    session[:user_type]="vendor"
  end
  def index
    @vendor = Vendor.find(session[:vendor_id])
    
  end

  def vendorlogin

  end

  def create
    vendor = Vendor.from_omniauth(env["omniauth.auth"])
    session[:vendor_id] = vendor.id
    # @vendor_name = "hello"
    # redirect_to root_url, notice: "Signed in!"
    redirect_to '/sessions/new', notice: "Signed in!"
    # redend "new"
  end

  def show
    # @vendor = Vendor.
   # @vendor = Vendor.find(session[:vendor_id])
    # session[:vendor_code] = vendor.code
    # @vendor.code = "54321"
    # session[:vendor_id] = vendor.id
    # vendor = Vendor.from_omniauth(env["omniauth.auth"])
    # session[:vendor_id] = vendor.id
    # redirect_to session_
  end

  def update
  end


  def edit

  end



  def destroy
    session[:vendor_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end


end
