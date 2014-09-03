class AddAccountIdToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :account_id, :integer
  end
end
