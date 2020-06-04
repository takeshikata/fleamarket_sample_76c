class AddShippingPayerToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :shipping_payer, null: false, foreign_key: true
  end
end
