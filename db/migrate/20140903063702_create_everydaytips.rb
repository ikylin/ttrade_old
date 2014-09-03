class CreateEverydaytips < ActiveRecord::Migration
  def change
    create_table :everydaytips do |t|
      t.text :tip

      t.timestamps
    end
  end
end
