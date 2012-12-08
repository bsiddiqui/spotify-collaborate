class SessionsController < ApplicationController
  def new
  end

  def create
    auth_hash = request.env['omniauth.auth']
    uid = auth_hash["uid"]
    user = User.new(:uid => uid)
    if user.save
      session[:user_id] = user.id
      redirect_to "/static_pages/index", :alert => "Thanks for signing up!"
    else
      session[:user_id] = User.find_by_uid(uid).id
      redirect_to "/static_pages/index", :alert => "Welcome Back"
    end
  end

  def failure
  end

  def destroy
    destroy_session
    redirect_to "/static_pages.index", :alert => "Signed Out" 
  end
end
