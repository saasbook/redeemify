class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :current_user, :current_provider, :current_vendor,
    :current_offeror, :offeror_codes

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_provider
    @current_provider ||= Provider.find(session[:provider_id]) if session[:provider_id]
  end

  def current_vendor
    @vendor ||= Vendor.find(session[:vendor_id]) if session[:vendor_id]
  end
  
  def provider?
    params[:controller] == "providers"
  end
  
  def current_offeror
    provider? ? current_provider : current_vendor
  end
  
  def offeror_codes
    provider? ? current_provider.redeemifyCodes : current_vendor.vendorCodes
  end
  
  def validation_errors_content(err_hash)
    now = Time.now.to_formatted_s(:long_ordinal)
    all_codes = err_hash[:submitted_codes]
    err_codes = err_hash[:err_codes]
    content = "#{all_codes} new #{'code'.pluralize(all_codes)} submitted to update the code set on #{now}\r\n"
    content = "#{content}#{err_codes} #{'code'.pluralize(err_codes)} failed through validation checks, comprising\r\n" if err_codes
     
    err_hash.each do |key, value|
      
      if value.is_a? Array
        content = "#{content}\r\n#{value.length} #{'code'.pluralize(value.length)} #{key}:\r\n"
        value.each {|c| content = "#{content}#{c}\r\n"}   
      end  
    end  
    content
  end  

  def new
  end
end
