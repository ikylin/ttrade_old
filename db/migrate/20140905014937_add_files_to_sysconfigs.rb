class AddFilesToSysconfigs < ActiveRecord::Migration
  def change
    add_attachment :sysconfigs, :imgfile
    add_attachment :sysconfigs, :txtfile
  end
end
