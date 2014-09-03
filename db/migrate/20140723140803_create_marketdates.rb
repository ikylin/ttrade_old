class CreateMarketdates < ActiveRecord::Migration
  def change
    create_table :marketdates do |t|
      t.date :tradedate
      t.string :daystate

      t.timestamps
    end
  end
end
