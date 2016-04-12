class AddRatingToCriterium < ActiveRecord::Migration
  def change
    add_column :criteria, :rating, :integer
  end
end
