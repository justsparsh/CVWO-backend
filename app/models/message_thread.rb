class MessageThread < ApplicationRecord
    belongs_to :user, foreign_key: 'userID'
    has_many :posts, foreign_key: 'threadID'
end