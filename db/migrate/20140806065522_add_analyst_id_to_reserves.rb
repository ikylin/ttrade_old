class AddAnalystIdToReserves < ActiveRecord::Migration
  def change
    add_column :reserves, :analyst_id, :integer
  end
end
