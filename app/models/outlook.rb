class Outlook < ActiveRecord::Base
  attr_accessible :outlook_sheet, :user_id, :status
   has_attached_file :outlook_sheet,
  :url  => "/jobs/outlook/:basename.:extension",
                  :path => ":rails_root/public/jobs/outlook/:basename.:extension" 
end
