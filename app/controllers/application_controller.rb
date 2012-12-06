class ApplicationController < ActionController::Base
  protect_from_forgery  

  helper_method :current_user, :destroy_session
  
  private

  def current_user
    begin
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue
      nil
    end
  end

  def destroy_session
  	@current_user = nil
  	session[:user_id] = nil
  end

  def authenticate_user!
  	redirect_to parties_path, :alert => "You must be signed in to do that." unless current_user
  end

end