class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.date :setdate
      t.string :name
      t.integer :tradenum
      t.decimal :winratio, precision: 5, scale: 2
      t.decimal :plratio, precision: 5, scale: 2
      t.decimal :profitmax, precision: 6, scale: 2
      t.decimal :lossmax, precision: 6, scale: 2

      t.timestamps
    end
  end
end
