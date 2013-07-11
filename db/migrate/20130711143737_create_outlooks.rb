class CreateOutlooks < ActiveRecord::Migration
  def change
    create_table :outlooks do |t|
      t.attachment :outlook_sheet
      t.integer :user_id
      t.string :status

      t.timestamps
    end
  end
end
