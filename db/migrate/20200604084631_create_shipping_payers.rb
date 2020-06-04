class CreateShippingPayers < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_payers do |t|
      t.integer :buyer, null: false
      t.integer :seller, null: false
      t.timestamps
    end
  end
end
