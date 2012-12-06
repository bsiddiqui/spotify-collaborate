class Party < ActiveRecord::Base
  attr_accessible :name, :songs, :party_id

  validates_presence_of :user_id

  has_many :songs
  belongs_to :user

  before_save :create_code

  def to_param
    code
  end

  def create_code
    begin
      self.code = SecureRandom.hex(10)
    end while self.class.exists?(code: code)
  end

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
