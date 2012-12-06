class UsersController < ApplicationController
  def new
  end

  def edit
  end

  def show
  end

  def index
    @user = current_user
  end

  def destroy
    destroy_session
    redirect_to parties_path, :alert => "Signed Out" 
  end
  
  def update
  end

end
