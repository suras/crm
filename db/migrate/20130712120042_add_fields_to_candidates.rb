class AddFieldsToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :middle_name, :string, :after => :first_name
    add_column :candidates, :home_phone, :string, :after => :contact_number
    add_column :candidates, :business_phone, :string, :after => :home_phone
    add_column :candidates, :referred_by, :string, :after => :facebook
  end
end
