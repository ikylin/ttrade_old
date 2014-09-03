class AddMarketdateToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :marketdate, :date
  end
end
