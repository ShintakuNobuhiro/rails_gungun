class AddIndexToAcquitions < ActiveRecord::Migration
  def change
    add_index :acquisitions, [:category_id, :mission_id], unique: true
  end
end
