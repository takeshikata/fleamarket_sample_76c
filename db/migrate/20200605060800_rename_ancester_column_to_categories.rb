class RenameAncesterColumnToCategories < ActiveRecord::Migration[5.2]
  def change
    rename_column :categories, :ancester, :ancestry
  end
end
