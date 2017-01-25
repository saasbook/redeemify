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
  
  def validation_errors_content(errHash)
    now = Time.now.to_formatted_s(:long_ordinal)
    allCodes = errHash[:submittedCodes]
    errCodes = errHash[:errCodes]
    content = "#{allCodes} new #{'code'.pluralize(allCodes)} submitted to update the code set on #{now}\n"
    content = "#{content}#{errCodes} #{'code'.pluralize(errCodes)} failed through validation checks, comprising\n" if errCodes
     
    errHash.each do |key, value|
      
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
