class Assign < ActiveRecord::Base
  belongs_to :mission
  belongs_to :user
  
  validates :mission_id, presence: true
  validates :user_id, presence: true
  
end
