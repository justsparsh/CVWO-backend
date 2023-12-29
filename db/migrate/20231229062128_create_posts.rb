class CreatePosts < ActiveRecord::Migration[7.1]  
  def change
    create_table :posts do |t|
      t.integer :userID
      t.string :userName
      t.text :text
      t.boolean :isParentPost
      t.integer :parentPostId
      t.integer :childPostId, array: true, default: []

      t.timestamps
    end
  end
end
