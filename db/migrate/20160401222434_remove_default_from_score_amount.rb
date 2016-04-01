class RemoveDefaultFromScoreAmount < ActiveRecord::Migration
  def change
    change_column :scores, :amount, :integer, default: nil
  end
end
