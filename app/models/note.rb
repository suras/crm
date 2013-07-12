class Note < ActiveRecord::Base
  attr_accessible :creater_id, :candidate_note, :candidate_id
  belongs_to :candidate
  belongs_to :creater, :class_name=>"User", :foreign_key=>"creater_id"
end
