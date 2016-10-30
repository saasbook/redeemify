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
    if session[:user_id] != nil
      current_user = User.find(session[:user_id])
      # debugger
      @list_codes, @instruction, @description, @help, @expiration, @website, @cashValue, @total = {},{},{},{},{},{},{},0

      if current_user.code.nil? # provider code
        redeemifyCode = RedeemifyCode.where(:code => params[:code], :user_id => nil).first
        if redeemifyCode != nil # if provider code is match with enter code
          # 1st time
          redeemifyCode.update_attributes(:user_id => current_user.id, :user_name => current_user.name, :email => current_user.email)
          provider = Provider.all.first
          provider.update_attribute(:usedCodes, provider.usedCodes + 1)
          provider.update_attribute(:unclaimCodes, provider.unclaimCodes - 1)


          @current_code = params[:code]

          current_user.code = @current_code
          current_user.save!  

          @vendors = Vendor.all

          @vendors.each do |vendor|
            code = vendor.vendorCodes.where(:user_id=>nil).first
            if code != nil
              code.update_attributes(:user_id => current_user.id, :user_name => current_user.name, :email => current_user.email)
              vendor.update_attribute(:usedCodes, vendor.usedCodes + 1)
              vendor.update_attribute(:unclaimCodes, vendor.unclaimCodes - 1)

              @list_codes[vendor.name] = code.code
              @total = @total + vendor.cashValue.gsub(/[^0-9\.]/,'').to_f
              @total = @total.round(2) 
            else
              @list_codes[vendor.name] = "Not Available"
              flash.now[:alert] = 'Some Offers\' code are not available at this time, please come back later'
            end 
              @instruction[vendor.name] = vendor.instruction
              @help[vendor.name] = vendor.helpLink
              @expiration[vendor.name] = vendor.expiration
              @website[vendor.name] = vendor.website
              @cashValue[vendor.name] = vendor.cashValue
              @description[vendor.name] = vendor.description
            # debugger
          end
        else # the provider code is not match
          redirect_to '/sessions/new', :flash => { :error => "wrong code!" }
        end

      else
        #2nd time
        @current_code = current_user.code
        @vendorCodes = VendorCode.where(:user_id => current_user.id)

        @vendors = Vendor.all
        @vendors.each do |vendor|
          @vendorCodes = vendor.vendorCodes.where(:user_id => current_user.id).first
          if @vendorCodes != nil
            @list_codes[vendor.name] = @vendorCodes.code
            @instruction[vendor.name] = vendor.instruction
            @help[vendor.name] = vendor.helpLink
            @expiration[vendor.name] = vendor.expiration
            @website[vendor.name] = vendor.website
            @cashValue[vendor.name] = vendor.cashValue
            @description[vendor.name] = vendor.description
            @total = @total + vendor.cashValue.gsub(/[^0-9\.]/,'').to_f
            @total = @total.round(2)
          else
            code = vendor.vendorCodes.where(:user_id=>nil).first
            if code != nil
              code.update_attributes(:user_id => current_user.id, :user_name => current_user.name, :email => current_user.email)
              vendor.update_attribute(:usedCodes, vendor.usedCodes + 1)
              vendor.update_attribute(:unclaimCodes, vendor.unclaimCodes - 1)

              @list_codes[vendor.name] = code.code
              @total = @total + vendor.cashValue.gsub(/[^0-9\.]/,'').to_f
              @total = @total.round(2)
            else
              @list_codes[vendor.name] = "Not Available"
              flash.now[:alert] = 'Some Offers\' code are not available at this time, please come back later'
            end 
            @instruction[vendor.name] = vendor.instruction
            @help[vendor.name] = vendor.helpLink
            @expiration[vendor.name] = vendor.expiration
            @website[vendor.name] = vendor.website
            @cashValue[vendor.name] = vendor.cashValue
            @description[vendor.name] = vendor.description
          end
        end
      end  #else
    end
    if session[:vendor_id] != nil
      @vendor_user = session[:vendor_id]
    end
  end



  def delete_page
    
  end

  def delete_account
    current_user = User.find(session[:user_id])
    if current_user != nil
      current_user.update_attributes(:name => "anonymous", :email => "anonymous", :provider => "anonymous")
      redeemifyCode = RedeemifyCode.where(:user_id => current_user.id).first
      redeemifyCode.update_attributes(:user_name =>"anonymous", :email => "anonymous")
      
      vendors = Vendor.all
      vendors.each do |vendor|
        vendorCode = vendor.vendorCodes.where(:user_id => current_user.id).first
        if vendorCode != nil
          vendorCode.update_attributes(:user_name => "anonymous", :email => "anonymous")
          
        end
      end
      session[:user_id] = nil
      redirect_to root_url, :flash => { :notice => "Your account has been deleted" }
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
