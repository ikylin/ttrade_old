class AddAvatarToAccounts < ActiveRecord::Migration
  def change
		add_attachment :accounts, :avatar
  end
end
