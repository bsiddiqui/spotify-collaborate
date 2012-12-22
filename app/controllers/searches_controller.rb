class SearchesController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  # renders a list of all the searches that have been performed. Users never see this page
  def index
    @searches = Search.all

    respond_to do |format|
      format.html 
      format.json { render json: @searches }
    end
  end

  # called when a user searches for a party (under "join a party") to redirect them to the correct page. 
  # if the code the user enters in the search box is not in our database, we alert the user with a message
  def show
    @search = Search.find(params[:id])
    @party = Party.includes(:songs).where("code = ?", @search.code).first
    if @party != nil
      redirect_to party_path(@party)
    else
      redirect_to (:back), :alert => "A Playlist with that code does not exist, please try again."
    end
  end


  # creates a new entry in the Search database before each search is performed
  def new
    @search = Search.new
    respond_to do |format|
      format.html 
      format.json { render json: @search }
    end
  end

  # stores information for a newly created search query in the Search database and redirects them to the searched Party's 
  # playlist page if it is successfully stored; otherwise, it alerts the user with an error message
  def create
    @search = Search.new(params[:search])

    respond_to do |format|
      if @search.save
        format.html { redirect_to @search}
        format.json { render json: @search, status: :created, location: @search }
      else
        format.html { render action: "new" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  # deletes a search entry in the Search database
  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.html { redirect_to searches_url }
      format.json { head :no_content }
    end
  end
end
