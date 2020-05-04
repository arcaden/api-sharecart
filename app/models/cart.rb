class Cart < ApplicationRecord
  belongs_to :room
  has_many :items
  validates :store_name, presence: true, uniqueness: true
  validates :created_by_id, presence: true


  def self.user_carts(user)
    room = Room.find(user.part_of_id)
    carts = Cart.where(room_id: room.id)
  end

  def self.create_cart(params, user)
    params = params.merge({created_by_id: user.id, room_id: user.part_of_id})
    cart = Cart.create!(params)
  end

end
