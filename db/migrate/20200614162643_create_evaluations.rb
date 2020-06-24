class CreateEvaluations < ActiveRecord::Migration[5.2]
  def change
    create_table :evaluations do |t|
      t.references :user, foreign_key: true, null: false
      t.references :product, foreign_key: true, null: false
      t.integer :evaluation_good, null: false, default: 0
      t.integer :evaluation_soso, null: false, default: 0
      t.integer :evaluation_bad, null: false, default: 0
      t.timestamps
    end
  end
end
