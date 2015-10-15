class RenameCardIdToUsers < ActiveRecord::Migration
  def change
    rename_column :users, :card_id, :card_number
  end
end
