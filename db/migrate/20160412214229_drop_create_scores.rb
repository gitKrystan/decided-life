class DropCreateScores < ActiveRecord::Migration
  def change
    drop_table :create_scores
  end
end
