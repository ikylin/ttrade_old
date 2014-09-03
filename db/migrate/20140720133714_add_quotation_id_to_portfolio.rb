class AddQuotationIdToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :quotation_id, :integer
  end
end
