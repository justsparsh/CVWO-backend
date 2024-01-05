class ChangePosts < ActiveRecord::Migration[7.1]
  def change
    change_table :posts do |t|
      t.remove :isParentPost
      t.rename :parentPostId, :threadID
      t.remove :childPostId
    end
  end
end
  
