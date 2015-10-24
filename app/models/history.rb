class History < ActiveRecord::Base
  belongs_to :user
  belongs_to :mission
  validates :user_id, presence: true
  validates :mission_id, presence: true
  validates :experience, numericality: {greater_than_or_equal_to: 0}
end
