class Mission < ActiveRecord::Base
  belongs_to :category
  belongs_to :level
  has_many :acquisitions
  has_many :assigns
  
  validates :level_id, presence: true
  validates :category_id, presence: true
  validates :description, presence: true, length: { maximum: 20 }
end
