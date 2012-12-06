class User < ActiveRecord::Base
	attr_accessible :nickname, :uid
  
  validates_uniqueness_of :uid
  
  has_many :parties

  has_many :evaluations, class_name: "RSEvaluation", as: :source

	has_reputation :votes, source: {reputation: :votes, of: :songs}, aggregated_by: :sum

	def voted_for?(song)
	  evaluations.where(target_type: song.class, target_id: song.id).present?
	end
  
end
