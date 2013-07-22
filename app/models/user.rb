class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
 has_attached_file :profile_pic, :styles => { :small => "150x150>" },
                  :url  => "/assets/users/:id/avatar/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/users/:id/avatar/:style/:basename.:extension",
                   :default_url => "/assets/profile_pic.png"
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :company,:profile_pic,
                   :user_type, :status, :team_id,  :register_type, :name
  attr_accessor  :register_type, :name
  def name
    "#{first_name.to_s} #{last_name.to_s}" 
  end
  
  after_create :create_team  

  belongs_to :team

  has_many :notes ,:foreign_key=>"creater_id", :dependent => :destroy
  
  def create_team
   if register_type.blank? 
     return
    else
     @team = Team.create( :owner_id => self.id, :status => 1)
     self.team = @team
     self.update_attributes(:user_type => 'owner',:team_id=>@team.id)
   end
 end
 
  
  
  
 
  
  
  
  
end
