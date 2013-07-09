class Shortlist < ActiveRecord::Base
   attr_accessible :candidate_id, :status, :call_list_id
   belongs_to :call_list
end
