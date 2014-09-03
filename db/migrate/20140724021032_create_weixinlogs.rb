class CreateWeixinlogs < ActiveRecord::Migration
  def change
    create_table :weixinlogs do |t|
      t.datetime :time
      t.text :content

      t.timestamps
    end
  end
end
