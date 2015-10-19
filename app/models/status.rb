class Status < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  validates :user_id, presence: true
  validates :category_id, presence: true
  validates :experience, numericality: {greater_than_or_equal_to: 0 }
  validates :recent_experience, numericality: {greater_than_or_equal_to: 0 }
  
  def level
    lv = 0
    levels = Level.all.order("value ASC")
    levels.each do |level|
      if level.sufficiency < experience
        lv = level.value
      end
    end
    lv
  end
end
