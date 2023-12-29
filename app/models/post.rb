class Post < ApplicationRecord
    belongs_to :user, foreign_key: 'userID'
    serialize :childPostId, JSON
  end