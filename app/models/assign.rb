class Assign < ActiveRecord::Base
  belongs_to :mission
  belongs_to :user
  validates :mission_id, presence: true, uniqueness: { scope: [:user_id] }
  validates :user_id, presence: true
  validates :achievement, inclusion: { in: [true, false] }
  validate :mission_s_category_must_be_unique

  private

  def mission_s_category_must_be_unique
    if user && mission
      user.assigns.each do |assign|
        errors.add(:mission, "mission's category must be unique") if assign.mission.category_id == mission.category_id
      end
    end
  end
end