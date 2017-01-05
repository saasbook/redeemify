class SessionsController < ApplicationController
  
  def new
    if session[:vendor_id] != nil
      @vendor_user = session[:vendor_id]
    end
    if current_user == nil
      @user = User.new
    else
      if current_user.code.nil?
        @user = User.new
      else
        redirect_to '/sessions/customer', notice: "Already register call from sessions#new"
      end
    end
  end


  def create  # Need to implement whether it's vendor or user
    auth = request.env["omniauth.auth"]
    
    provider = Provider.find_by_provider_and_email(auth["provider"], auth["info"]["email"])
    if provider != nil
      session[:provider_id]= provider.id
      redirect_to '/providers/home', notice: "home page, Provider"
    else
      vendor = Vendor.find_by_provider_and_email(auth["provider"], auth["info"]["email"])
      if vendor != nil
        session[:vendor_id]= vendor.id
        redirect_to '/vendors/home', notice: "home page, vendor"
      else
        user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
        # debugger
        session[:user_id] = user.id
        if user.code.nil? 
          redirect_to '/sessions/new', notice: "Signed in!"
        else
          redirect_to '/sessions/customer'
        end
      end
    end
  end


  def customer
    if session[:user_id]
      @list_codes, @instruction, @description, @help, @expiration, @website, @cashValue, @total = {},{},{},{},{},{},{},0

      if current_user.code.nil?
        unless RedeemifyCode.serve current_user, params[:code] 
        #sad path: no match for submitted token
          flash.now[:error] = "Your code is either invalid or has been redeemed already.<br />Please enter a valid redeemify code.".html_safe
          render :new ; return
        end  
      end
        #setting up vendor codes for current user
        @current_code = current_user.code
        vendors = Vendor.all
        vendors.each do |vendor|
          code = vendor.serve_code current_user
          flash.now[:alert] = 'Some offers\' code are not available at this time, please come back later' unless code
          
          @list_codes[vendor.name] ||= code ? code.code : "Not Available"
          @instruction[vendor.name] ||= vendor.instruction
          @help[vendor.name] ||= vendor.helpLink
          @expiration[vendor.name] ||= vendor.expiration
          @website[vendor.name] ||= vendor.website
          @cashValue[vendor.name] ||= vendor.cashValue
          @description[vendor.name] ||= vendor.description
          @total += vendor.cashValue.gsub(/[^0-9\.]/,'').to_f
          @total = @total.round(2)
        end
    end
    if session[:vendor_id] != nil
      @vendor_user = session[:vendor_id]
    end
  end



  def delete_page
    
  end

  def delete_account
    if current_user != nil
      current_user.anonymize!
      RedeemifyCode.anonymize! current_user
      VendorCode.anonymize_all! current_user

      session[:user_id] = nil
      redirect_to root_url, :flash => { :notice => "Your account has been deleted." }
    end
  end


  def destroy
    session[:user_id] = nil
    session[:vendor_id] = nil
    session[:provider_id] = nil
    gon.clear
    redirect_to root_url, notice: "Signed out!"
  end



  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
  end

  def change_to_vendor
    session[:user_id] = nil
    redirect_to '/vendors/home', notice: "Change to Vendor Account"
  end

  def hello_user
  end

  def welcome_user
  end

  def enter_user
  end

  def exit_user
  end

  def login_user
  end

  def logout_user
  end


end
