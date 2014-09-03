class AddAnalystIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :analyst_id, :integer
  end
end
