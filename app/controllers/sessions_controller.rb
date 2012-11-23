class SessionsController < ApplicationController
	skip_before_filter :authenticate_user

  def new
  end

  def create
	 	auth_hash = request.env['omniauth.auth']
	  @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
	  if @authorization
	  	session[:user_id] = User.find_by_email(auth_hash["info"]["email"]).id
	    render :text => "Welcome back #{@authorization.user.name}! You have already signed up."
	  else
	    user = User.new :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"]
	    user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
	    user.save
	    render :text => "Hi #{user.name}! You've signed up."
	  end
  end

  def destroy
  	session[:user_id] = nil
  	render :text => "You've logged out!"
	end

	def failure
		render :text => "Sorry, but you didn't allow access to our app!"
	end
end
