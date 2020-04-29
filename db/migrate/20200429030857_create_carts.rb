class CreateCarts < ActiveRecord::Migration[6.0]
  def change
    create_table :carts do |t|
      t.string :store_name
      t.belongs_to :room
      t.references :created_by, index: true, foreign_key: { to_table: :users }
      t.timestamps
    end
  end
end
