class Song < ActiveRecord::Base
  attr_accessible :name, :artist, :track_key, :user, :party_id

  has_reputation :votes, source: :user, aggregated_by: :sum

  validates_presence_of :party_id, :name, :artist, :track_key

  belongs_to :party

end
