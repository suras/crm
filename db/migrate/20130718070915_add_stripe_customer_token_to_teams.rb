class AddStripeCustomerTokenToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :stripe_customer_token, :string
  end
end
