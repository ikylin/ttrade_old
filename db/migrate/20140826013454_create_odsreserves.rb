class CreateOdsreserves < ActiveRecord::Migration
  def change
    create_table :odsreserves do |t|
      t.string :code
      t.string :name
      t.string :plate
      t.decimal :open, precision: 6, scale: 2
      t.decimal :high, precision: 6, scale: 2
      t.decimal :low, precision: 6, scale: 2
      t.decimal :close, precision: 6, scale: 2
      t.decimal :dprofit, precision: 5, scale: 2
      t.integer :duration

      t.timestamps
    end
  end
end
