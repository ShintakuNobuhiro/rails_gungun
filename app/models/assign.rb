class Assign < ActiveRecord::Base
  belongs_to :mission
  belongs_to :user
  validates :mission_id, presence: true, uniqueness:{scope: [:user_id] }
  validates :user_id, presence: true
  validates :achievement, presence: true
end
