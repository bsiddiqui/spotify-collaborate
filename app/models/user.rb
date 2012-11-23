class User < ActiveRecord::Base
  attr_accessible :email, :name
  has_many :authorizations
  validates_presence_of :name, :email
end
