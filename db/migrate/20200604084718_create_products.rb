class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :user, type: :bigint, null: false, foreign_key: true
      t.string :name, null: false
      t.text :introduction, null: false
      #t.references :category, type: :bigint, foreign_key: true
      #t.references :brand, type: :bigint, foreign_key: true
      #t.references :product_condition, type: :bigint, foreign_key: true
      #t.references :shipping_payer, type: :bigint, foreign_key: true
      #t.references :shipping_region, type: :bigint, foreign_key: true
      #t.references :preparation_term, type: :bigint, foreign_key: true
      t.integer :price, null: false
      t.timestamps
    end
  end
end
