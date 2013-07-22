class Team < ActiveRecord::Base
  attr_accessible :name, :status, :owner_id
  has_many :users
  
  
  
end
