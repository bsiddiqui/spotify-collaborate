class FixColumnName < ActiveRecord::Migration
  def change
  	change_table :parties do |t|
  		t.rename :party_id, :id 
  	end
  end
end

