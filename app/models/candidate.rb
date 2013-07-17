class Candidate < ActiveRecord::Base
  attr_accessible :company, :experience, :first_name, :last_name, :profile_pic, :resume, :first_name,
                  :last_name, :email, :address, :city, :state, :zip, :contact_number, :team_id, :user_id,
                  :added_from, :linked_in, :twitter, :facebook, :position,:name, :unique_id

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

 validates :email,  :first_name, :presence => true
 validates :email, :email => true, :uniqueness=>true
 has_many :notes


 before_create :generate_unique_id
 belongs_to :user
 belongs_to :team
 has_one :call_list, :through=> :shortlist
 has_one :shortlist
 
 
 def generate_unique_id
   self.unique_id = generate_random(self.email)
   
 end
 
 def generate_random(mail_str)
   "candidate_" + mail_str.slice(0, mail_str.index('@')) + rand(1111..9999).to_s
   
 end

 scope :status, lambda{ |status| where("shortlists.status"=>status)}
 delegate :name, :to=>:user, :prefix=>true
 has_and_belongs_to_many :tags
 attr_reader :get_tags, :profile_pic_url,:get_notes, :name
 

 def as_json options={}
  {
    id: self.id,
    company: self.company,
    experience: self.experience,
    name: "#{self.first_name} #{self.last_name}",
    first_name: self.first_name,
    last_name: self.last_name,
    profile_pic_url: self.profile_pic_url,
    get_tags: self.get_tags,
    position: self.position,
    email: self.email,
    address: self.address,
    state: self.state,
    zip: self.zip,
    contact_number: self.contact_number,
    added_from: self.added_from,
    linked_in: self.linked_in,
    facebook: self.facebook,
    twitter: self.twitter,
    notes: self.get_notes,
    resume: self.resume,
    added_by: self.name
  }
    # options ||= {}
    # options[:methods] = ((options[:methods] || []) + [:get_tags,:profile_pic_url])
    # super options
 end
 def name
    "#{self.first_name} #{self.last_name}"
  end
 before_create :save_image
  
 def save_image
   
 end

 def get_tags
    self.tags.select(:name).map(&:name).join(",")
 end
 def get_notes
    self.notes
 end

  def profile_pic_url
    self.profile_pic(:small)
  end

end
