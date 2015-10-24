class RemoveJapanesNameToRole < ActiveRecord::Migration
  def change
    remove_column :roles, :japanese_name
  end
end
