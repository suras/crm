class Category < ActiveRecord::Base
  attr_accessible :branch, :degree
  has_many :candidates
end
