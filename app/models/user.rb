class User < ApplicationRecord
    has_many :posts, foreign_key: 'userID'
    validates :name, uniqueness: true
end
