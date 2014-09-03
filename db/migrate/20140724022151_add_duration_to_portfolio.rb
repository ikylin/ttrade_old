class AddDurationToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :duration, :integer
  end
end
