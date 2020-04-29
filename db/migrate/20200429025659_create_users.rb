class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
      t.references :part_of, index: true, foreign_key: { to_table: :rooms }
      t.timestamps
    end
  end
end

