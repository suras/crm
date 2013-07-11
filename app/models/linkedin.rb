class Linkedin < ActiveRecord::Base
  attr_accessible :linkedin_sheet, :user_id, :status
   has_attached_file :linkedin_sheet,
  :url  => "/jobs/linkedin/:basename.:extension",
                  :path => ":rails_root/public/jobs/linkedin/:basename.:extension" 
end
