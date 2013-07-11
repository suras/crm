class AddUserIdToExcels < ActiveRecord::Migration
  def change
    add_column :excels, :user_id, :integer
  end
end
