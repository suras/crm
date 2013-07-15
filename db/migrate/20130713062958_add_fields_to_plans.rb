class AddFieldsToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :max_user, :integer
  end
end
