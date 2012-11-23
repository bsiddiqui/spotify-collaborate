class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :authenticate_user

  def current_user
  	@current_user ||= User.find_by_id(session[:user_id])
  end

  def authenticate_user
    redirect_to login_path unless current_user
  end
end
