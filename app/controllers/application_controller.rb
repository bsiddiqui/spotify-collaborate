class ApplicationController < ActionController::Base
  protect_from_forgery  

  helper_method :current_user, :destroy_session
  
  private # sets the methods as private/protected 

  # sets current_user, keeps user logged in
  def current_user
    begin
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue
      nil
    end
  end

  # called when user logs out
  def destroy_session
  	@current_user = nil
  	session[:user_id] = nil
  end

  # checks to see if user is facebook authenticated through omni-auth 
  def authenticate_user!
  	redirect_to "/login", :alert => "You must be signed in to do that." unless current_user
  end

end