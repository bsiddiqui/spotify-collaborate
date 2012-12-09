class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|
      t.string :code
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
