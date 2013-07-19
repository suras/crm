class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name, :company,
                   :user_type, :status, :team_id, :plan_id, :register_type, :name, :stripe_card_token, :stripe_customer_token
  attr_accessor :plan_id, :register_type, :name, :stripe_card_token 
  def name
    "#{first_name.to_s} #{last_name.to_s}" 
  end
  before_create :save_with_payment
  after_create :create_team  
  before_destroy :cancel_subscription            
  # attr_accessible :title, :body
  belongs_to :team
  has_many :call_lists, :dependent => :destroy
  has_many :notes ,:foreign_key=>"creater_id", :dependent => :destroy
  def create_team
   if register_type.blank? 
     return
    else
     @team = Team.create( :owner_id => self.id, :status => 'pending', :plan_id => self.plan_id, :stripe_customer_token => self.stripe_customer_token)
     self.team = @team
     self.user_type = 'owner'
     #self.team_id = @team.id
     self.save
   end
 end
  def save_with_payment
    if register_type.blank? 
     return
    else
    if valid?
      customer = Stripe::Customer.create(description:email, 
        plan: plan_id, email: email, card: stripe_card_token)
      self.stripe_customer_token = customer.id
      
    end
   end
    rescue Stripe::InvalidRequestError => e
      logger.error "Stripe error while creating customer: #{e.message}"
      errors.add :base, "There was a problem with your credit card."
      false
  end
  
  def cancel_subscription
     unless stripe_customer_token.nil? 
      customer = Stripe::Customer.retrieve(stripe_customer_token)
      unless customer.nil? or customer.respond_to?('deleted')
        #if customer.subscription.status == 'active'
          customer.cancel_subscription
        #end
      end
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to cancel your subscription. #{e.message}."
    false
    
    
  end
  
  def plan_update(user_plan_id)
    unless stripe_customer_token.nil?
      customer = Stripe::Customer.retrieve(stripe_customer_token)
      customer.update_subscription(:plan => user_plan_id)
       team = self.team
       team.plan_id = user_plan_id
       team.save
    end
   
    true
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "Unable to update your subscription. #{e.message}."
    false
  end
  
  def card_update(card_token)
    unless stripe_customer_token.nil?
      customer = Stripe::Customer.retrieve(stripe_customer_token) 
      customer.card = card_token
      customer.email = email
      customer.description = email
      customer.save
    end
  rescue Stripe::StripeError => e
    logger.error "Stripe Error: " + e.message
    errors.add :base, "#{e.message}."
    self.stripe_token = nil
    false
  end
  
  
  
end
