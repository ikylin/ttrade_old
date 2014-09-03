class AddDurationToReserves < ActiveRecord::Migration
  def change
    add_column :reserves, :duration, :integer
    add_column :reserves, :catchdate, :date
    add_column :reserves, :releasedate, :date
  end
end
