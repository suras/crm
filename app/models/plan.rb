class Plan < ActiveRecord::Base
  attr_accessible :amount, :description, :name, :max_user
  has_many :teams
end
