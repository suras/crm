class Candidate < ActiveRecord::Base
  attr_accessible :company, :experience, :first_name, :last_name, :profile_pic, :resume, :first_name,
                  :last_name, :email, :address, :city, :state, :zip, :contact_number, :team_id, :user_id,
                  :added_from, :linked_in, :twitter, :facebook, :position

 has_attached_file :profile_pic, :styles => { :small => "150x150>" },
                  :url  => "/assets/candidates/:id/avatar/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/candidates/:id/avatar/:style/:basename.:extension",
                   :default_url => "/assets/images/company.jpg"
 has_attached_file :resume,
                  :url  => "/assets/candidates/:id/resume/:basename.:extension",
                  :path => ":rails_root/public/assets/candidates/:id/resume/:basename.:extension" 
                  
                                  
validates_attachment_content_type :profile_pic, :content_type => ['image/jpeg', 'image/png', 'image/gif']
validates_attachment_content_type :resume, :content_type => ["application/pdf", "application/msword", 
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
             "text/plain"]


 validates :contact_number, :length => {:minimum => 6, :maximum => 25}, :format => { :with => /\A\S[0-9\+\/\(\)\s\-]*\z/i }, :allow_blank => true

 validates :email, :presence => true
 validates :email, :email => true, :uniqueness=>true

 
 belongs_to :user
 belongs_to :team
 has_and_belongs_to_many :tags

 before_create :save_image
 
 
 def save_image
   
 end

 attr_reader :get_tags, :profile_pic_url
 def as_json options=nil
    options ||= {}
    options[:methods] = ((options[:methods] || []) + [:get_tags,:profile_pic_url])
    super options
  end
 def get_tags
    self.tags.select(:name).map(&:name).join(",")
 end
 
 def profile_pic_url
    self.profile_pic(:small)
  end

end
