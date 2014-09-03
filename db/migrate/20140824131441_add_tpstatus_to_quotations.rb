class AddTpstatusToQuotations < ActiveRecord::Migration
  def change
    add_column :quotations, :tpstatus, :string
    add_column :quotations, :cqstatus, :string
  end
end
