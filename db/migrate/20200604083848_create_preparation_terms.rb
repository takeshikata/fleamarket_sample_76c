class CreatePreparationTerms < ActiveRecord::Migration[5.2]
  def change
    create_table :preparation_terms do |t|

      t.timestamps
    end
  end
end
