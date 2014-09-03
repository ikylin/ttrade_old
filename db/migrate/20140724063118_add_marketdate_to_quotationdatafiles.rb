class AddMarketdateToQuotationdatafiles < ActiveRecord::Migration
  def change
    add_column :quotationdatafiles, :marketdate, :date
  end
end
