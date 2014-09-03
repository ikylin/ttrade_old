class AddMarketdateToQuotations < ActiveRecord::Migration
  def change
    add_column :quotations, :marketdate, :date
  end
end
