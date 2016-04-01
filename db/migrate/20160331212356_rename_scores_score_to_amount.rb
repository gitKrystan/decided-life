class RenameScoresScoreToAmount < ActiveRecord::Migration
  def change
    rename_column :scores, :score, :amount
  end
end
