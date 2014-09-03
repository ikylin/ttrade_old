class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.date :buydate
      t.decimal :buyprice, precision: 6, scale: 2
      t.decimal :profit, precision: 6, scale: 2
      t.decimal :volum, precision: 2, scale: 1
      t.string :option

      t.timestamps
    end
  end
end
