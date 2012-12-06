class PartiesController < ApplicationController
  # before_filter :authenticate_user!, :except => :index

  # include Spotify

  def new
    @party = Party.new
  end

  def edit
  end

  def show
    #@party = Party.find(params[:id])
    @party = Party.includes(:songs).where("code = ?", params[:id]).first
    @songs = @party.songs.find_with_reputation(:votes, :all, order: 'votes desc')
    #@songs = @party.songs.find_with_reputation(:votes, :all, order: 'votes desc')
    #@songssongs = Song.where("party_id = ?", params[:id])
    #@songs = @songssongs.find_with_reputation(:votes, :all, order: 'votes desc')

    @party_tracks = @party.party_tracks
    @song = Song.new
  end

  def index
  #  @url = parties_url
   # @parties = Party.find_all_by_name(params[:search])
  #  respond_to do |format|
   #   format.html {  }
 #     format.js

  # if params[:Find_Playlist]
      #if Party.exists?(:code => params[:id])
        
        #render "/parties/#{params[:q]}"
     # end
  # end
  end

  def search
  #    @party = Party.includes(:songs).where("code = ?", params[:q]).first
   #   p @party
    #  if @search.nil?
     #   redirect_to :action => "show", :alert => "Incorrect Code"
   #   else
    #    redirect_to :action => "show"
  #    end
  redirect_to "/parties/#{params[:q]}"


  end
    
     # redirect_to party_path(@party)

  #  else
  #    redirect_to :action => "index", :alert => "Incorrect Code"
  #  end
  #end

  def create
    party = Party.new(params[:party])
    party.user = current_user

    if party.save
      redirect_to party_path(party)
    else 
      redirect_to new_party_path, :alert => "Error"
    end
  end
  
#  def create_unique_identifier
 #   begin
#     self. code = SecureRandom.uuid # or whatever you chose like UUID tools
 #   end while self.class.exists?(:code => code)
# end


  def update
  end

  def destroy
  end

end
