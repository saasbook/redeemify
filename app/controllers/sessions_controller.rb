class SessionsController < ApplicationController
  before_action :require_login, except: [:new, :create]

  def new
    if session[:vendor_id].present?
      @vendor_user = session[:vendor_id]
    end
  end

  def create
    if offeror.present?
      log_in(offeror)
      redirect_to "/#{offeror.class.to_s.downcase.pluralize}/home",
        notice: "Welcome, #{offeror.name}"
    else
      user = find_or_create_user
      log_in(user)
      if user.code.present?
        redirect_to '/sessions/customer'
      else
        redirect_to '/sessions/new', notice: "Signed in!"
      end
    end
  end
  
  def customer
    if session[:user_id]
      if current_user.code.nil?
        unless RedeemifyCode.serve(current_user, params[:code])
          flash.now[:error] = 
            'Your code is either invalid or has been redeemed already.
              <br>Please enter a valid redeemify code.'.html_safe
          render :new ; return
        end
      end
      set_vendor_code(current_user)
    end
    if session[:vendor_id].present?
      @vendor_user = session[:vendor_id]
    end
  end
  
  def delete_page
  end

  def delete_account
    if current_user.present?
      current_user.anonymize!
      RedeemifyCode.anonymize! current_user
      VendorCode.anonymize_all! current_user
      session.delete(:user_id)
      redirect_to root_url, notice: "Your account has been deleted"
    end
  end

  def destroy
    session.delete(:user_id)
    session.delete(:vendor_id)
    session.delete(:provider_id)
    gon.clear
    redirect_to root_url, notice: "Signed out!"
  end

  def failure
    redirect_to root_url, alert: "Authentication failed, please try again"
  end

  def change_to_vendor
    session[:user_id] = nil
    redirect_to '/vendors/home', notice: "Changed to vendor account"
  end

  private
  
  def require_login
    unless authenticated_user
      redirect_to '/' and return
    end
  end
  
  def offeror
    auth = request.env["omniauth.auth"]
    Provider.find_by_provider_and_email(auth["provider"], auth["info"]["email"]) || 
    Vendor.find_by_provider_and_email(auth["provider"], auth["info"]["email"])
  end

  def log_in(user)
    key = "#{user.class.to_s.downcase}_id".to_sym
    session[key] = user.id
  end

  def find_or_create_user
    auth = request.env["omniauth.auth"]
    User.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
    User.create_with_omniauth(auth)
  end
  
  def set_vendor_code(current_user)
    set_instance_variables
    Vendor.all.each do |vendor|
      vendor_code = vendor.serve_code(current_user)
      flash.now[:alert] = t('missing_offer') unless vendor_code
      @codes[vendor.name] ||= vendor_code ? vendor_code.code : 'Not available'
      vendor.attributes.slice('cash_value', 'expiration', 'description',
        'instruction', 'website', 'help_link').each { 
          |key, value| instance_variable_get("@#{key}")[vendor.name] ||= value }
      @total += vendor.cash_value
    end
  end
  
  def set_instance_variables
    @codes, @instruction, @description, @help_link, @expiration, @website,
    @cash_value, @total = {}, {}, {}, {}, {}, {}, {}, 0
    @current_code = current_user.code
  end
end
