class Search < ActiveRecord::Base
  attr_accessible :content, :code, :title

  has_many :songs
end

#def to_param
 #   code
  #end

#def create_code
 #     @party = Party.Find_by_code(params[:code])
  #    code = @party.code
    
  #end