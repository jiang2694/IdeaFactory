class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  has_secure_password

  has_many :ideas, dependent: :nullify
  has_many :reviews, dependent: :nullify
  has_many :likes
  has_many :liked_ideas, through: :likes, source: :idea
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: VALID_EMAIL_REGEX
end
