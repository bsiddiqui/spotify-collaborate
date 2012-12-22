class SessionsController < ApplicationController
  def new
  end

  # creates a new account for first time users
  # authenticates and logs in the user through omni-auth/facebook
  # if the user's information saves to the database, it redirects 
  #the user to their home page, else it displays an error message
  def create
    $auth_hash = request.env['omniauth.auth']
    uid = $auth_hash["uid"] 
    user = User.new(:uid => uid)
    if user.save
      session[:user_id] = user.id
      redirect_to new_party_path, :alert => "Thanks for signing up!"
    else
      session[:user_id] = User.find_by_uid(uid).id
      redirect_to user_path(current_user), :alert => "Welcome Back"
    end
  end

  def failure
  end

  # calls the destroy_session method when the user logs out
  def destroy
    destroy_session
    redirect_to "/static_pages.index", :alert => "Signed Out" 
  end
end
