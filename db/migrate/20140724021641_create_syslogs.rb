class CreateSyslogs < ActiveRecord::Migration
  def change
    create_table :syslogs do |t|
      t.string :role
      t.datetime :time
      t.string :opt
      t.string :curstate

      t.timestamps
    end
  end
end
