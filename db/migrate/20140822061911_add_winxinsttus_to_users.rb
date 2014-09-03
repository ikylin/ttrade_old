class AddWinxinsttusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :weixinstatus, :integer
    add_column :users, :guanzhudate, :date
    add_column :users, :quxiaoguanzhudate, :date
  end
end
