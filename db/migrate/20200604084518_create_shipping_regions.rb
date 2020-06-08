class CreateShippingRegions < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_regions do |t|
      t.integer :region, null: false, default: 0
      t.timestamps
    end
  end
end
