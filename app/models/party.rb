class Party < ActiveRecord::Base
  attr_accessible :name, :songs

  validates_presence_of :user_id

  has_many :songs
  belongs_to :user


  # Used for the Spotify API call

  def party_tracks
    party_tracks = []
    songs_ordered.each do |song|
      party_tracks << song.track_key.gsub("spotify:track:","")
    end
    party_tracks.join(',')
  end

  private 

  def songs_ordered
    self.songs.find_with_reputation(:votes, :all, order: 'votes desc')
  end

end
