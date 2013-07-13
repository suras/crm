class AddStatusToExcels < ActiveRecord::Migration
  def change
    add_column :excels, :status, :string, :default => 0
  end
end
