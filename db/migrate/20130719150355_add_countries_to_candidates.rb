class AddCountriesToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :country, :string
  end
end
