class CreateLinkedins < ActiveRecord::Migration
  def change
    create_table :linkedins do |t|
      t.attachment :linkedin_sheet
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
