class AddProfitToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :profit, :decimal, precision: 5, scale: 2
  end
end
