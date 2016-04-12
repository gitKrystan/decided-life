class RemoveAmountFromScore < ActiveRecord::Migration
  def change
    remove_column :scores, :amount
  end
end
