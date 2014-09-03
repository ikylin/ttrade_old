class AddMarketdateToReserves < ActiveRecord::Migration
  def change
    add_column :reserves, :marketdate, :date
  end
end
