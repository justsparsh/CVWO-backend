class RemoveUserIdFromUsers < ActiveRecord::Migration[7.1]
  def change
    remove_column :users, :userId, :integer
  end
end
