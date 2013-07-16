class CallList < ActiveRecord::Base
  attr_accessible :status, :name, :user_id 
  has_many :candidates, :through=>:shortlists
  has_many :shortlists, :dependent => :destroy
  belongs_to :user
end
