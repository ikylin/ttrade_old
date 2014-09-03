class CreateQuotations < ActiveRecord::Migration
  def change
    create_table :quotations do |t|
      t.string :code
      t.string :name
      t.string :plate
      t.decimal :open, precision: 6, scale: 2
      t.decimal :high, precision: 6, scale: 2
      t.decimal :low, precision: 6, scale: 2
      t.decimal :close, precision: 6, scale: 2

      t.timestamps
    end
  end
end
