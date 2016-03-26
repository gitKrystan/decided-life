class AddUserToMatrices < ActiveRecord::Migration
  def change
    add_reference :matrices, :user, index: true, foreign_key: true
  end
end
