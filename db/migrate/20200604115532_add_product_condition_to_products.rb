class AddProductConditionToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :product_condition, null: false, foreign_key: true
  end
end
