class Level < ActiveRecord::Base
    has_many :missions
    validates :value, numericality: {greater_than: 0}
    validates :sufficiency, numericality: {greater_than_or_equal_to: 0}
end
