class AddProfilePicToUsers < ActiveRecord::Migration
  def change
  	add_attachment :users, :profile_pic
  	add_column :users, :own_email, :string
  end
end
