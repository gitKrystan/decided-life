class ChangeCriteriumRankingDefault < ActiveRecord::Migration
  def change
    change_column_default :criteria, :rating, 3
  end
end
