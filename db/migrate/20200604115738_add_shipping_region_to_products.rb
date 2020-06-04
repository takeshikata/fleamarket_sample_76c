class AddShippingRegionToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :shipping_region, null: false, foreign_key: true
  end
end
