class Note < ActiveRecord::Base
  attr_accessible :creater_id, :candidate_note, :candidate_id
  belongs_to :candidate
  belongs_to :creater, :class_name=>"User", :foreign_key=>"creater_id"
  def as_json(options={})
    {
    id: self.id,
    date: self.created_at.strftime("%m/%d/%Y"),
    candidate_note: self.candidate_note,
    candidate_id: self.candidate_id
    }
  end
end
