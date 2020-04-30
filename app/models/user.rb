class User < ApplicationRecord
  has_secure_password
  has_many :carts, foreign_key: "created_by", dependent: :nullify
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }
  
  def rooms(id)
    return Room.find(id)
  end

  def join_room(name)
    room = Room.find_by! name
    User.update(part_of_id: room.id)
    return room
  rescue ActiveRecord::RecordNotFound 
    room = Room.create!(name)
    User.update(part_of_id: room.id)
    return room
  end
end
