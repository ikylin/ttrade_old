class AddCfgnameToSysconfigs < ActiveRecord::Migration
  def change
    add_column :sysconfigs, :cfgname, :string
    add_column :sysconfigs, :cfginteger, :integer
		rename_column :sysconfigs, :marketdate, :cfgdate
    rename_column :sysconfigs, :batchstart, :cfgtime
    remove_column :sysconfigs, :batchend, :time
    add_column :sysconfigs, :cfgstring, :string
    add_column :sysconfigs, :cfgtext, :text
  end
end
