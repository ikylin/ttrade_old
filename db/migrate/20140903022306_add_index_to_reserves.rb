class AddIndexToReserves < ActiveRecord::Migration
  def change
    add_index :reserves, [:marketdate, :quotation_id], unique: true
  end
end
