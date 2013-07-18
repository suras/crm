Stripe.api_key = "sk_test_hYSE5FZnwX7PTa8m6lduHRQ5"
STRIPE_PUBLIC_KEY = "pk_test_I6bw9rXwcB0dYxdzqoE127HM"


StripeEvent.setup do
  subscribe 'charge.failed' do |event|
    # Define subscriber behavior based on the event object
    #event.class #=> Stripe::Event
    #event.type  #=> "charge.failed"
    #event.data  #=> { ... }
    team = Team.find_by_stripe_customer_token(event.data.object.customer)
    team.status = "rejected"
    team.save
  end
  
  subscribe 'charge.succeeded' do |event|
    # Define subscriber behavior based on the event object
    #event.class #=> Stripe::Event
    #event.type  #=> "charge.failed"
    #event.data  #=> { ... }
    team = Team.find_by_stripe_customer_token(event.data.object.customer)
    team.status = "charged"
    team.save
  end


   subscribe 'customer.deleted' do |event|
    # Define subscriber behavior based on the event object
    #event.class #=> Stripe::Event
    #event.type  #=> "charge.failed"
    #event.data  #=> { ... }
    team = Team.find_by_stripe_customer_token(event.data.object.customer)
    if(team.present?)
      team.status = "deleted"
      team.save
    end
  end
  #subscribe 'customer.created', 'customer.updated' do |event|
    # Handle multiple event types
  #end

  #subscribe do |event|
    # Handle all event types - logging, etc.
  #end
end