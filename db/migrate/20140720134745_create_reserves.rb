class CreateReserves < ActiveRecord::Migration
  def change
    create_table :reserves do |t|
      t.string :stockstatus
      t.decimal :hhv, precision: 6, scale: 2
      t.decimal :llv, precision: 6, scale: 2
      t.date :hdate
      t.date :ldata
      t.decimal :profit, precision: 6, scale: 2
      t.decimal :loss, precision: 6, scale: 2
      t.decimal :plratio, precision: 6, scale: 2
      t.text :note

      t.timestamps
    end
  end
end
