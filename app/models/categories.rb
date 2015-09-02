class Categories < ActiveRecord::Base
    has_many :missions, dependent: :destroy
    has_many :acquisitions, dependent: :destroy
end
