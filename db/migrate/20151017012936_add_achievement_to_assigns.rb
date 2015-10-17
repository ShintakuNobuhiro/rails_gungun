class AddAchievementToAssigns < ActiveRecord::Migration
  def change
    add_column :assigns, :achievement, :boolean, default: false
  end
end
