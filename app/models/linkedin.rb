class Linkedin < ActiveRecord::Base
  attr_accessible :linkedin_sheet, :user_id, :status
   has_attached_file :linkedin_sheet,
  :url  => "/jobs/linkedin/:basename.:extension",
                  :path => ":rails_root/public/jobs/linkedin/:basename.:extension" 
   validates_attachment_content_type :linkedin_sheet, :content_type => ["application/vnd.ms-excel",     
             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"]
      validates :linkedin_sheet, :attachment_presence => true
end
