class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.references :category, foreign_key: true
      t.references :brand, foreign_key: true
      t.references :product_condition, foreign_key: true
      t.references :shipping_payer, foreign_key: true
      t.references :shipping_region, foreign_key: true
      t.references :preparation_term, foreign_key: true
      t.integer :price, null: false
      t.timestamps
    end
  end
end
