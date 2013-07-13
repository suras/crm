class DbSeed < ActiveRecord::Migration
  def change
  	Plan.create(:amount=>100, :description=>"Single user", :name=>"Silver", :max_user=>1)
  	Plan.create(:amount=>400, :description=>"Multi user", :name=>"Platinum", :max_user=>20)
  	Plan.create(:amount=>200, :description=>"Multi user", :name=>"Gold", :max_user=>5)
  end
end
