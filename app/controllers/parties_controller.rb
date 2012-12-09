class PartiesController < ApplicationController
  before_filter :authenticate_user!, :except => :index

  # include Spotify

  # creates a new entry in the database "Party"
  def new
    @party = Party.new
  end

  def edit
  end

  # searches the Party database for the corresponding party that should be displayed,
  # and temporarily saves all corresponding information about the party (songs, party name, etc.)
  # to send to the view to be rendered
  def show
    @party = Party.includes(:songs).where("code = ?", params[:id]).first
    @songs = (@party.songs).sort! { |a,b| b[:votes] <=> a[:votes]}
    @party_tracks = @party.party_tracks
    @song = Song.new
  end

  def index
  end

  # stores information for a newly created party in the Party database and redirects them to the Party's 
  # playlist page if it is successfully stored; otherwise, it alerts the user with an error message
  def create
    party = Party.new(params[:party])
    party.user = current_user

    if party.save
      redirect_to party_path(party)
    else 
      redirect_to new_party_path, :alert => "Error"
    end
  end

  def update
  end

  def destroy
  end

end
