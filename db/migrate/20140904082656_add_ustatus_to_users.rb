class AddUstatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ustatus, :string
  end
end
