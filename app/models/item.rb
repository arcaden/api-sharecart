class Item < ApplicationRecord
    belongs_to :cart
    has_one :users, foreign_key: "requested_by", dependent: :nullify
end
