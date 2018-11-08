class User < ApplicationRecord

  has_secure_password

  has_many :news_articles

  has_many :products, dependent: :destroy
  has_many :reviews, dependent: :destroy
  
  has_many :votes, dependent: :destroy
  has_many :voted_reviews, through: :votes, source: :review

  has_many :likes, dependent: :destroy

  has_many :liked_reviews, through: :likes, source: :review

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
