class CreatePortfoliologs < ActiveRecord::Migration
  def change
    create_table :portfoliologs do |t|
      t.string :opt
      t.datetime :time

      t.timestamps
    end
  end
end
