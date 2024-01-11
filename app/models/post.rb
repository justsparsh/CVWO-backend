class Post < ApplicationRecord
    belongs_to :user, foreign_key: 'userID'
    belongs_to :message_thread, foreign_key: 'threadID', class_name: 'MessageThread'
  end