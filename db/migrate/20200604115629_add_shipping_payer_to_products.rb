class AddShippingPayerToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :shipping_payer, foreign_key: true
  end
end
