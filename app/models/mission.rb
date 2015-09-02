class Mission < ActiveRecord::Base
  belongs_to :category
  belongs_to :level
  has_many :acquisitions, dependent: :destroy
  has_many :assign, dependent: :destroy
end
