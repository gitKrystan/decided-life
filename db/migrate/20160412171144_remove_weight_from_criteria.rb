class RemoveWeightFromCriteria < ActiveRecord::Migration
  def change
    remove_column :criteria, :weight
  end
end
