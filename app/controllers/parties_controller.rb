class PartiesController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  # include Spotify

  def new
    @party = Party.new
  end

  def edit
  end

 def show
    @party = Party.includes(:songs).where("code = ?", params[:id]).first
    @songs = (@party.songs).sort! { |a,b| b[:votes] <=> a[:votes]}
    @party_tracks = @party.party_tracks
    @song = Song.new
  end

  def index
  end

  def search
  redirect_to "/parties/search/#{params[:q]}"
  end

  def create
    party = Party.new(params[:party])
    party.user = current_user

    if party.save
      redirect_to party_path(party)
    else 
      redirect_to new_party_path, :alert => "You must be signed in to do that"
    end
  end

  def update
  end

  def destroy
  end

end
