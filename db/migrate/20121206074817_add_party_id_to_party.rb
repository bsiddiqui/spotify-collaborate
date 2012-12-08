class AddPartyIdToParty < ActiveRecord::Migration
  def change
    add_column :parties, :party_id, :string
  end
end
