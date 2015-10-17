class AddRecentExperienceToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :recent_experience, :integer
  end
end
