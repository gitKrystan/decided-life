class AddBinToScores < ActiveRecord::Migration
  def change
    add_reference :scores, :bin, index: true, foreign_key: true
  end
end
