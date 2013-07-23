class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :degree
      t.string :branch

      t.timestamps
    end
  end
end
