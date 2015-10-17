class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :mission
  validates :user_id, presence: true
  validates :mission_id, presence: true
  validates :experience, numericality: {greater_than: 0 }
  validates :recent_experience, numericality: {greater_than: 0 }
end
