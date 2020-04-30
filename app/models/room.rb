class Room < ApplicationRecord
    has_many :carts
    has_many :users, foreign_key: "part_of_id", dependent: :nullify
    validates :name, presence: true, uniqueness: true
end
