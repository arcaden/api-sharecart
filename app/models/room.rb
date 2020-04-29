class Room < ApplicationRecord
    has_many :carts
    validates :name, presence: true, uniqueness: true
end
