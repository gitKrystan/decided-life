class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :criterium, index: true, foreign_key: true
      t.references :option, index: true, foreign_key: true
      t.integer :score, default: 0

      t.timestamps null: false
    end
  end
end
