class Category < ActiveRecord::Base
    has_many :missions
    has_many :aqcuisitions
    validates :name , presence: true
end
