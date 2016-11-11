class ApplicationController < ActionController::Base
  # protect_from_forgery

  protect_from_forgery with: :exception
  helper_method :current_user, :current_provider

private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_provider
    @current_provider ||= Provider.find(session[:provider_id]) if session[:provider_id]
  end

  def new
  end
end
