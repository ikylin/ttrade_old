class CreateQuotationdatafiles < ActiveRecord::Migration
  def change
    create_table :quotationdatafiles do |t|
      t.string :filetype
      t.string :filestatus
			t.attachment	:avatar

      t.timestamps
    end
  end
end
