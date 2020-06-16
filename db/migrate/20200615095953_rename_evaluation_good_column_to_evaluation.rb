class RenameEvaluationGoodColumnToEvaluation < ActiveRecord::Migration[5.2]
  def change
    rename_column :evaluations, :evaluation_good, :evaluation
  end
end
