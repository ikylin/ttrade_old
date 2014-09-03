class AddDurationToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :duration, :integer
    add_column :accounts, :wincount, :integer
    add_column :accounts, :losscount, :integer
  end
end
