class CreateAnalysts < ActiveRecord::Migration
  def change
    create_table :analysts do |t|
      t.string :name
      t.string :lvl
      t.integer :fan

      t.timestamps
    end
  end
end
