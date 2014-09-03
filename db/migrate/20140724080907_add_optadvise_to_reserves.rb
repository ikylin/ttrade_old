class AddOptadviseToReserves < ActiveRecord::Migration
  def change
    add_column :reserves, :optadvise, :string
  end
end
