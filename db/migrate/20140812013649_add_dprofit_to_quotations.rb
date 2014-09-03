class AddDprofitToQuotations < ActiveRecord::Migration
  def change
    add_column :quotations, :dprofit, :decimal, precision: 5, scale: 2
  end
end
