class ChangeWeightDefaultInCriteria < ActiveRecord::Migration
  def change
    change_column_default :criteria, :weight, 100
  end
end
