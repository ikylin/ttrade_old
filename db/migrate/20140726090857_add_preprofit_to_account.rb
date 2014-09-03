class AddPreprofitToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :pretradenum, :integer
    add_column :accounts, :preprofit, :decimal, precision: 5, scale: 2
    add_column :accounts, :prewincount, :integer
    add_column :accounts, :prelosscount, :integer
  end
end
