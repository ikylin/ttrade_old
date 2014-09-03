class AddUserIdToAnalyst < ActiveRecord::Migration
  def change
    add_column :analysts, :user_id, :integer
  end
end
