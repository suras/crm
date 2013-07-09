class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :candidate
      t.text :candidate_note
      t.integer :creater_id
      

      t.timestamps
    end
    add_index :notes, :candidate_id
  end
end
