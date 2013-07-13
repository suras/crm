class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.attachment :resume
      t.string :status
      t.integer :user_id

      t.timestamps
    end
  end
end
