class CreateThreads < ActiveRecord::Migration[7.1]
  def change
    create_table :threads do |t|
      t.integer :userID
      t.string :userName
      t.text :text
      t.text :threadTitle

      t.timestamps
    end
  end
end
