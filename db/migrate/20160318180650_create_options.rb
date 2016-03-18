class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.references :matrix, index: true, foreign_key: true
      t.string :name
      t.integer :sequence

      t.timestamps null: false
    end
  end
end
