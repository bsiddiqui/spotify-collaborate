class Search < ActiveRecord::Base
  attr_accessible :content, :code, :title
  has_many :songs
end
