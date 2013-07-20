class Outlook < ActiveRecord::Base
  attr_accessible :outlook_sheet, :user_id, :status
   has_attached_file :outlook_sheet,
  :url  => "/jobs/outlook/:basename.:extension",
                  :path => ":rails_root/public/jobs/outlook/:basename.:extension" 
   validates_attachment_content_type :outlook_sheet, :content_type => ["application/vnd.ms-excel",     
             "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"] 
    validates :outlook_sheet, :attachment_presence => true              
end
