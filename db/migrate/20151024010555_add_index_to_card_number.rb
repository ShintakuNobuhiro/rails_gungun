class AddIndexToCardNumber < ActiveRecord::Migration
  def change
    add_index :users, :card_number, unique: true
  end
end
