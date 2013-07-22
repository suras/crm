class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :encrypted_password, :null => false, :default => ""
      t.string :college
      t.string :email, :null => false, :default => ""
      t.string :company
      t.string :experience
      t.attachment :resume
      t.attachment :profile_pic
      t.string :address
      t.string :country
      t.string :state
      t.string :city
      t.string :zip
      t.string :contact_number
      t.references :team
      t.references :user
      t.string :added_from
      t.string :linked_in
      t.string :twitter
      t.string :facebook
      t.string :position
      t.string :referred_by
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip
      

      t.timestamps
    end
    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end
