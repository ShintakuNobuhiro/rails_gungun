class AddIndexToValue < ActiveRecord::Migration
  def change
    add_index :levels, :value, unique: true
  end
end
