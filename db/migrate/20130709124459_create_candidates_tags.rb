class CreateCandidatesTags < ActiveRecord::Migration
  def change
    create_table :candidates_tags do |t|
      t.references :candidate
      t.references :tag
    end
  end


end
