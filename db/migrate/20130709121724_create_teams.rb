class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.string :status
      t.integer :owner_id
      t.references :plan

      t.timestamps
    end
  end
end
