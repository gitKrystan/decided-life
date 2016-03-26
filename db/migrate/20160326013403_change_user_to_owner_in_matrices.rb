class ChangeUserToOwnerInMatrices < ActiveRecord::Migration
  def change
    rename_column :matrices, :user_id, :owner_id
  end
end
