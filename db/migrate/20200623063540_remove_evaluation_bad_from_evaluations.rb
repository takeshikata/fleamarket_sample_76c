class RemoveEvaluationBadFromEvaluations < ActiveRecord::Migration[5.2]
  def change
    remove_column :evaluations, :evaluation_bad, :integer
  end
end
