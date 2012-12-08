class SongsController < ApplicationController
include Spotify

	def new
		@party = Party.includes(:songs).where("id = ?", params[:party_id]).first
  
    	@song = Song.new(:name => params[:name],
						:artist => params[:artist],
						:track_key => params[:track_key],
						:party_id => params[:party_id],
						:votes => 0)

    	p @song
    	 #@songs = @party.songs.find_with_reputation(:votes, :all, order: 'votes desc')
    	 #@songssongs = Song.where("party_id = ?", params[:party_id])
    	#@songs = @songssongs.find_with_reputation(:votes, :all, order: 'votes desc')


		@songs = @party.songs.find_with_reputation(:votes, :all, order: 'votes desc')
		#@song = @party.Song.new(:name => params[:name],
		#						 :artist => params[:artist],
		#						 :track_key => params[:track_key])

		@song.party = @party #this was here already
		@party_tracks = @party.party_tracks
		if @song.save
			respond_to do |format|
	      		format.js
	    	end
	  	else
	  		redirect_to party_path(@party), :alert => "could not add song"
	  	end
	end

  	def create
    	@songs = call(params[:song][:name])[0..25]
    	@party_id = params[:song][:party_id]
    	respond_to do |format|
     		format.js
    	end
  	end

  	def destroy
  		@song = Song.find_by_party_id_and_name(params[:party_id], params[:name])
  		@song.destroy
  		redirect_to(:back)
  		#@votecount = @song.votes
  		#	@song.update_attribute(:votes, @votecount + 1)
  		#	redirect_to :action => :show, :id => params[:party_id]
  		#end
  	end

  	def update
        @song = Song.find_by_party_id_and_name(params[:party_id], params[:name])
      if params[:commit] == "Upvote"
          @song.update_attribute(:votes, @songs.votes + 1)
          redirect_to(:back)
        end
        if params[:commit] == "Downvote"
          @song.update_attribute(:votes, @song.votes - 1)
          redirect_to(:back)
        end
      end
  		#@votecount = @song.votes
  		#	@song.update_attribute(:votes, @votecount + 1)
  		#	redirect_to :action => :show, :id => params[:party_id]
  		#end


  #	def vote
 # 		value = params[:type] == "up" ? 1 : -1
#		@song = Song.find(params[:id])
#		begin
#	  		@song.add_or_update_evaluation(:votes, value, current_user)
#		rescue
#		end
#		@party = Party.find(params[:party_id])
 #   	@songs = @party.songs.find_with_reputation(:votes, :all, order: 'votes desc')
#	  	respond_to do |format|
#	      	format.js
#	    end
 # 	end
end
