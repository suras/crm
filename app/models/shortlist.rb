class Shortlist < ActiveRecord::Base
   attr_accessible :candidate_id, :status, :call_list_id
   belongs_to :call_list
   belongs_to :candidate
   scope :accepted, joins(" inner join candidates on shortlists.candidate_id=candidates.id").where(:status=>'approved')
   scope :rejected, where(:status=>'rejected')
   scope :new_entry, where(:status=>nil)
end
