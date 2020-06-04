class CreatePreparationTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :preparation_terms do |t|
      t.integer :term, null: false 
      t.timestamps
    end
  end
end
