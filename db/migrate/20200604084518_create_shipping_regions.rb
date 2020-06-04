class CreateShippingRegions < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_regions do |t|
      t.integer :region, null: false
      t.timestamps
    end
  end
end
