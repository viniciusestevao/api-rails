class User < ApplicationRecord
  has_many :user_tokens
  has_many :candidates
  has_many :recruiters

  validates :username, :password, presence: true
  validates :username, uniqueness: true
  validates_length_of :password, minimum: 8

end
