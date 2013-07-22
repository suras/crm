class AddResumeDataToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :resume_data, :string
  end
end
