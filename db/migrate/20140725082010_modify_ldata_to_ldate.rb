class ModifyLdataToLdate < ActiveRecord::Migration
  def change
		change_table :reserves do |t|
			t.rename :ldata,	:ldate
		end
  end
end
