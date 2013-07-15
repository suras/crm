class Doc < ActiveRecord::Base
  attr_accessible :resume, :status, :user_id
   attr_accessible :resume, :user_id, :status
   has_attached_file :resume,
  :url  => "/jobs/docs/:basename.:extension",
                  :path => ":rails_root/public/jobs/docs/:basename.:extension"
    validates_attachment_content_type :resume, :content_type => ["application/msword", 
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]              
                  
               
end
