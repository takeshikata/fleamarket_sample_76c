class RemoveEvaluationSosoFromEvaluations < ActiveRecord::Migration[5.2]
  def change
    remove_column :evaluations, :evaluation_soso, :integer
  end
end
