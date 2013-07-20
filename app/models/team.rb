class Team < ActiveRecord::Base
  attr_accessible :name, :status, :owner_id, :plan_id, :stripe_customer_token
  has_many :users
  has_many :candidates
  has_many :call_lists, :through => :users
  belongs_to :plan
end
