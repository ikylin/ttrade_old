class AddWinpercentageToReserves < ActiveRecord::Migration
  def change
    add_column :reserves, :catchplratio, :decimal, precision: 5, scale: 2
    add_column :reserves, :winpercentage, :decimal, precision: 6, scale: 2
  end
end
