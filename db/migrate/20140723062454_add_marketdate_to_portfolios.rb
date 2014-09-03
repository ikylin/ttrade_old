class AddMarketdateToPortfolios < ActiveRecord::Migration
  def change
    add_column :portfolios, :marketdate, :date
  end
end
