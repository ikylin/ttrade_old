class RemoveIndexFromReserves < ActiveRecord::Migration
  def change
    remove_index :reserves, column: [:marketdate, :quotation_id] 
  end
end
