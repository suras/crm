class AddStopHereToShortlists < ActiveRecord::Migration
  def change
    add_column :shortlists, :left_on, :date, :default=>nil
    change_column :shortlists, :status, :string, :default=>"newly_added"
  end
end
