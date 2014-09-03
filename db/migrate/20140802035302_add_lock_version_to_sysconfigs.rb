class AddLockVersionToSysconfigs < ActiveRecord::Migration
  def change
    add_column :sysconfigs, :lock_version, :integer
  end
end
