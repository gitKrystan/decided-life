class CreateCriteria < ActiveRecord::Migration
  def change
    create_table :criteria do |t|
      t.references :matrix, index: true, foreign_key: true
      t.string :name
      t.integer :sequence
      t.integer :weight

      t.timestamps null: false
    end
  end
end
