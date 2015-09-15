class Level < ActiveRecord::Base
    has_many :missions 
    validates :value, numericality: {greater_than: 0}
    validates :sufficiencies, numericality: {greater_than: 0}
end
