class RenameColumnMissionIdToCategoryId < ActiveRecord::Migration
  def change
    rename_column :statuses, :mission_id, :category_id
  end
end
