class VendorsController < ApplicationController

  def index
    # @vendor = Vendor.find(session[:vendor_id])
  end


  def home
    @vendor = Vendor.find(session[:vendor_id])
  end

  def show
  end

  def edit
  end

  def destroy
    session[:vendor_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def hello
  end

  def welcome
  end

  def enter
  end

  def exit
  end

  def login
  end

  def logout
  end


end
