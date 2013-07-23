class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :company,
                   :user_type, :status, :team_id, :plan_id, :register_type,:name
  attr_accessor :plan_id, :register_type, :name
  def name
    "#{first_name.to_s} #{last_name.to_s}" 
  end
  after_create :create_team              
  # attr_accessible :title, :body
  belongs_to :team
  has_many :call_lists, :dependent => :destroy
  has_many :notes ,:foreign_key=>"creater_id", :dependent => :destroy
  def create_team
   if register_type.blank? 
     return
    else
     @team = Team.create( :owner_id => self.id, :status => 'pending', :plan_id => self.plan_id)
     self.team = @team
     self.user_type = 'owner'
     self.team_id = @team.id
     self.save
  end
end
  
end
