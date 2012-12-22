class UsersController < ApplicationController
  def new
    authenticate_user!
  end


  def edit
  end

  # queries database for parties associated with user to display on their homepage
  def show
    @parties=Party.new
    @parties=Party.find_all_by_user_id(current_user.id)
    if @parties == nil
      redirect_to new_party_path
    end
  end

  def index
    @user = current_user
  end

  # logs out the user
  def destroy
    destroy_session
    redirect_to parties_path, :alert => "Signed Out" 
  end
  
  def update
  end

end
