class RenameScoresScoreToAmount < ActiveRecord::Migration
  def change
    rename_column :scores, :score, :amount
    add_reference :scores, :matrix, index: true
  end
end
