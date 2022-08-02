class Idea < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true
    has_many :reviews, dependent: :destroy
    has_many :likes, dependent: :destroy
    has_many :likers, through: :likes, source: :user

    belongs_to :user
end
