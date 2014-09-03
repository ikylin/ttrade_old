class AddLvladviseToReserves < ActiveRecord::Migration
  def change
    add_column :reserves, :lvladvise, :integer
  end
end
