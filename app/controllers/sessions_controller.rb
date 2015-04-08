class SessionsController < ApplicationController
  
  def new
    if current_user == nil
      @user = User.new
    else
      if current_user.code == ""
        @user = User.new
      else
        redirect_to '/sessions/customer', notice: "Already register call from sessions#new"
      end
    end
  end


  def create  ## Need to implement whether it's vendor or user
    # user = User.from_omniauth(env["omniauth.auth"])
    auth = request.env["omniauth.auth"]
    
    vendor = Vendor.find_by_provider_and_email(auth["provider"], auth["info"]["email"])

    if vendor != nil
      session[:vendor_id]= vendor.id
      redirect_to '/vendors/home', notice: "home page, vendor"
    else
      user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
      if user.code.nil? || user.code == ""
        session[:user_id] = user.id
        # redirect_to root_url, notice: "Signed in!"
        redirect_to '/sessions/new', notice: "Signed in!"
      else
        session[:user_id]= user.id
        redirect_to '/sessions/customer', notice: "Offer page"
      end
    end
  end


  def customer
   
    if session[:user_id] != nil
      current_user = User.find(session[:user_id])
      if current_user.code.nil? || current_user.code == ""
        #1st time
        @current_code = params[:code]
        current_user.code = @current_code
        current_user.save!  

        @list_codes = {}
        @instruction = {}
        @help = {}
        @expiration = {}
        @website = {}
        @vendors = Vendor.all

        @vendors.each do |vendor|
          code = vendor.vendorCodes.where(:user_id=>nil).first
          # debugger
          if code != nil
            code.update_attribute(:user_id, current_user.id)
            # debugger
            @list_codes[vendor.name] = code.code
            @instruction[vendor.name] = code.instruction
            @help[vendor.name] = code.help
            @expiration[vendor.name] = code.expiration
            @website[vendor.name] = vendor.website
          else
            @list_codes[vendor.name] = "We are reloading with sleight of hand"
          end 
          # debugger
        end

      else
        #2nd time
        @current_code = current_user.code
        @list_codes = {}
        @instruction = {}
        @help = {}
        @expiration = {}
        @website = {}
        @vendors = VendorCode.where(:user_id => current_user.id)

        @vendors.each do |vendor|
          
          @list_codes[Vendor.find(vendor.vendor).name] = vendor.code
          @instruction[Vendor.find(vendor.vendor).name] = vendor.instruction
          @help[Vendor.find(vendor.vendor).name] = vendor.help
          @expiration[Vendor.find(vendor.vendor).name] = vendor.expiration
          @website[vendor.name] = vendor.vendor.website
        end
      end
    end
  end


  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again."
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
