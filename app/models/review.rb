class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user

  has_many :likes, dependent: :destroy

  has_many :likers, through: :likes, source: :user

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  # Validate that body is optional but the rating is required and must be a number between 1 and 5 inclusive.
  validates :rating, inclusion: {in: 1..5, message: "Rating needs to be between 1 and 5"}
end
