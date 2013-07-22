require "open-uri"
require 'digest'
class Candidate < ActiveRecord::Base
  attr_accessible :company, :experience, :first_name, :last_name, :profile_pic, :resume, :first_name,
                  :last_name, :email, :address, :city, :state, :zip, :contact_number,
                  :added_from, :linked_in, :twitter, :facebook, :position, :name, 
                  :country, :referred_by, :encrypted_password, :password, :password_confirmation
  attr_accessor  :password, :password_confirmation  

 has_attached_file :profile_pic, :styles => { :small => "150x150>" },
                  :url  => "/assets/candidates/:id/avatar/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/candidates/:id/avatar/:style/:basename.:extension",
                   :default_url => "/assets/profile_pic.png"
 has_attached_file :resume,
                  :url  => "/assets/candidates/:id/resume/:basename.:extension",
                  :path => ":rails_root/public/assets/candidates/:id/resume/:basename.:extension" 
                  
                                  
 validates_attachment_content_type :profile_pic, :content_type => ['image/jpeg', 'image/png', 'image/gif']
 validates_attachment_content_type :resume, :content_type => ["application/pdf", "application/msword", 
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
             "text/plain"]
             
  validates :password, :confirmation => true,
                       :length => { :within => 4..20 },
                       :presence => true
                              


 validates :contact_number, :length => {:minimum => 6, :maximum => 25}, :format => { :with => /\A\S[0-9\+\/\(\)\s\-]*\z/i }, :allow_blank => true

 validates :email,  :first_name, :presence => true
 validates :email, :email => true, :uniqueness=>true
 has_many :notes


 

 scope :status, (lambda do  |status,date=nil| 
    cond = "shortlists.status = '#{status}' "
    if date.nil? && date.blank?
      cond += "and shortlists.left_on is NULL"
    elsif !(date.nil? || date.blank?)
      cond += "and shortlists.left_on = '#{date}'"
    end
    where(cond)
  end)
 
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
    resume: self.resume_url,
    added_by: self.user_name
  }
    # options ||= {}
    # options[:methods] = ((options[:methods] || []) + [:get_tags,:profile_pic_url])
    # super options
 end
 
 def name
    "#{self.first_name} #{self.last_name}"
  end
 
  

 def resume_url
    self.resume.exists? ? self.resume.url :  "javascript:return(false);"
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
  
  before_save :encrypt_new_password
 
  def self.authenticate(email, password)
    candidate = find_by_email(email)
    return candidate if candidate && candidate.authenticated?(password)
  end
 
  def authenticated?(password)
    self.encrypted_password == encrypt(password)
  end
 
  protected
    def encrypt_new_password
      return if password.blank?
      self.encrypted_password = encrypt(password)
    end
 
    def password_required?
      encrypted_password.blank? || password.present?
    end
 
    def encrypt(string)
      Digest::SHA1.hexdigest(string)
    end
  


end
