class Thread < ApplicationRecord
    belongs_to :user, foreign_key: 'userID'
  end