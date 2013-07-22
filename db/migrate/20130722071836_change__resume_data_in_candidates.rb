class ChangeResumeDataInCandidates < ActiveRecord::Migration
  def up
    change_column :candidates, :resume_data, :binary, :limit => 10.megabyte
  end

  def down
    change_column :candidates, :resume_data
  end
end
