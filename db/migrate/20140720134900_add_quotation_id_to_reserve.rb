class AddQuotationIdToReserve < ActiveRecord::Migration
  def change
    add_column :reserves, :quotation_id, :integer
  end
end
