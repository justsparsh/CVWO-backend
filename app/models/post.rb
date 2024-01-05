class Post < ApplicationRecord
    belongs_to :user, foreign_key: 'userID'
    belongs_to :thread, foreign_key: 'threadID'
  end