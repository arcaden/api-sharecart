class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.float :price
      t.text :description
      t.belongs_to :cart
      t.timestamps
    end
  end
end
