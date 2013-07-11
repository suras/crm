class CreateExcels < ActiveRecord::Migration
  def change
    create_table :excels do |t|
      t.attachment :excel_sheet

      t.timestamps
    end
  end
end
