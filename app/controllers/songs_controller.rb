class SongsController < ApplicationController
  include Spotify

  # stores information for a newly added song in the Song database and redirects them to the searched Party's 
  # playlist page if it is successfully stored; otherwise, it alerts the user with an error message
  def new
    @party = Party.includes(:songs).where("id = ?", params[:party_id]).first

    @song = Song.new(:name => params[:name],
      :artist => params[:artist],
      :track_key => params[:track_key],
      :party_id => params[:party_id],
      :votes => 0)
    @songs = (@party.songs).sort! { |a,b| b[:votes] <=> a[:votes]}
    @song.party = @party 
    @party_tracks = @party.party_tracks
    if @song.save
      respond_to do |format|
        format.js
      end
    else
      redirect_to party_path(@party), :alert => "Could not add song."
    end
  end

  # creates a new entry for songs
  def create
    @songs = call(params[:song][:name])[0..25]
    @party_id = params[:song][:party_id]
    respond_to do |format|
      format.js
    end
  end

  # deletes a song from the database
  def destroy
    @song = Song.find_by_party_id_and_name(params[:party_id], params[:name])
    @song.destroy
    redirect_to(:back)
  end

  def index
  end

  # changes the vote count for a song when the user clicks "Up" or "Down"
  def show
    @song = Song.find_by_name_and_party_id(params[:song][:name], params[:song][:party_id])
    if params[:commit] == "Up"
      @votecount = @song.votes.to_i + 1
      @song.update_attribute(:votes, @votecount)
      redirect_to(:back)
    end
    if params[:commit] == "Down"
      @votecount = @song.votes.to_i - 1
      @song.update_attribute(:votes, @votecount)
      redirect_to(:back)
    end
  end
end