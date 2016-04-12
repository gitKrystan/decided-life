class RenameCriteriumRatingToImportance < ActiveRecord::Migration
  def change
    rename_column :criteria, :rating, :importance
  end
end
