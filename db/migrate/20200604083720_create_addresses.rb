class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.references :user, foreign_key: true
      t.string :first_name, null: false,
      t.string :last_name, null: false,
      t.string :first_name_kana, null: false,
      t.string :last_name_kana, null: false,
      t.integer :zip_code, null: false,
      t.integer :prefecture, null: false,
      t.string :city, null: false,
      t.string :street_number, null: false,
      t.string :apartment, 
      t.integer :telephone, 
      t.timestamps
    end
  end
end
