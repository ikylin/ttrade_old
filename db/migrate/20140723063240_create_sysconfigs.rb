class CreateSysconfigs < ActiveRecord::Migration
  def change
    create_table :sysconfigs do |t|
      t.date :marketdate
      t.time :batchstart
      t.time :batchend

      t.timestamps
    end
  end
end
