class CreateShortlists < ActiveRecord::Migration
  def change
    create_table :shortlists do |t|
      t.string :status
      t.references :candidate
      t.references :call_list

      t.timestamps
    end
    add_index :shortlists, :call_list_id
  end
end
