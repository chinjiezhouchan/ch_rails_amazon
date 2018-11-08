class Tag < ApplicationRecord

  has_many :taggings, dependent: :destroy

  has_many :products, through: :taggings

  before_validation :downcase_name

  validates :name, presence: true, uniqueness: true

  private

  def downcase_name
    self.name&.downcase!
  end
end
