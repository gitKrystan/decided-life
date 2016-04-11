class CreateBins < ActiveRecord::Migration
  def change
    create_table :bins do |t|
      t.integer :score
      t.string :description
      t.decimal :min
      t.decimal :max
      t.belongs_to :criterium, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
