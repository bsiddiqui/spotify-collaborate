class SearchesController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  def index
    @searches = Search.all

    respond_to do |format|
      format.html 
      format.json { render json: @searches }
    end
  end

  def show
    @search = Search.find(params[:id])
    @party = Party.includes(:songs).where("code = ?", @search.code).first
    if @party != nil
      redirect_to party_path(@party)
    else
      redirect_to (:back), :alert => "A Playlist with that code does not exist, please try again."
    end
  end

  def new
    @search = Search.new
    respond_to do |format|
      format.html 
      format.json { render json: @search }
    end
  end

  def edit
    @search = Search.find(params[:id])
  end

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

  def update
    @search = Search.find(params[:id])

    respond_to do |format|
      if @search.update_attributes(params[:search])
        format.html { redirect_to @search, notice: 'Search was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @search.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @search = Search.find(params[:id])
    @search.destroy

    respond_to do |format|
      format.html { redirect_to searches_url }
      format.json { head :no_content }
    end
  end
end
