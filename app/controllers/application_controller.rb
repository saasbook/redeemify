class ApplicationController < ActionController::Base
  # protect_from_forgery

  protect_from_forgery with: :exception
  helper_method :current_user, :current_provider, :current_vendor

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
  
  def validation_errors_content(err_Hash)
    now = Time.now.to_formatted_s(:long_ordinal)
    all_codes = err_Hash[:submitted_codes]
    err_codes = err_Hash[:err_codes]
    content = "#{all_codes} new #{'code'.pluralize(all_codes)} submitted to update the code set on #{now}\n"
    content = "#{content}#{err_codes} #{'code'.pluralize(err_codes)} failed through validation checks, comprising\n" if err_codes
     
    err_Hash.each do |key, value|
      
      if value.is_a? Array
        content = "#{content}\n#{value.length} #{'code'.pluralize(value.length)} #{key}:\n"
        value.each {|c| content = "#{content}#{c}\n"}   
      end  
    end  
    content
  end  

  def new
  end
end
