class AddPreparationTermToProducts < ActiveRecord::Migration[5.2]
  def change
    add_reference :products, :preparation_term, null: false, foreign_key: true
  end
end
