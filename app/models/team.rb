class Team < ActiveRecord::Base
  attr_accessible :name, :status, :owner_id, :plan_id
  has_many :users
  has_many :candidates
  has_many :call_lists, :through => :users
end
