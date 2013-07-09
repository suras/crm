class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :company
      t.string :experience
      t.attachment :resume
      t.attachment :profile_pic
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :contact_number
      t.references :team
      t.references :user
      t.string :added_from
      t.string :linked_in
      t.string :twitter
      t.string :facebook
      t.string :position
      

      t.timestamps
    end
  end
end
