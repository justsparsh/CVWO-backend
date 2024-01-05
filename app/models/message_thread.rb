class MessageThread < ApplicationRecord
    belongs_to :user, foreign_key: 'userID'
end