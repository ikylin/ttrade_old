class AddSellinfoToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :selldate, :date
    add_column :portfolios, :sellprice, :decimal, precision: 6, scale: 2
  end
end
