class AddUniqueIdToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :unique_id, :string
  end
end
