class Candidate < ActiveRecord::Base
  attr_accessible :company, :experience, :first_name, :last_name, :profile_pic, :resume, :first_name,
                  :last_name, :email, :address, :city, :state, :zip, :contact_number, :team_id, :user_id,
                  :added_from, :linked_in, :twitter, :facebook, :position

 has_attached_file :profile_pic, :styles => { :small => "150x150>" },
                  :url  => "/assets/candidates/:id/avatar/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/candidates/:id/avatar/:style/:basename.:extension"
 has_attached_file :resume,
                  :url  => "/assets/candidates/:id/resume/:basename.:extension",
                  :path => ":rails_root/public/assets/candidates/:id/resume/:basename.:extension"                 
 
 validates :email, :first_name, :presence => true
 validates :email, :uniqueness=>true
 
 belongs_to :user
 belongs_to :team
 has_and_belongs_to_many :tags
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
