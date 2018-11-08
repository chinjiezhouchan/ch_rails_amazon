class NewsArticle < ApplicationRecord

  belongs_to :user

  validates :title, presence: true, uniqueness: { case_sensitive: false }

  validates :description, presence: true

  # validate :published_after_created

  private

  # To access published_at or created_at properly, you need either self.published_at to call it on the model instance, or vanilla "published_at", which is an attribute accessor.
  # What I did wrong was that I made them symbols. Symbols are unique names for things.

  # Rails creates attr_accessors for each column in a table whenever you generate models.

  # Based on my test, published_at being nil always would be true.
  def published_after_created

    unless published_at.present?
      if published_at <= created_at
        errors.add(:published_at, "Can't publish before creating")
    
      end
    end
  end

  def titleize
    self.title = self.title.titleize
  end

  def publish
    self.published_at = Time.now
  end

end
