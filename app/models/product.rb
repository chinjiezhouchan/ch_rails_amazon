class Product < ApplicationRecord

  belongs_to :user, optional: true

  has_many :taggings, dependent: :destroy

  has_many :tags, through: :taggings

  has_many :reviews, dependent: :destroy # the other option is nullify, which leaves the foreign keys in I think.
  # validates :title, :price, presence: true, uniqueness: { case_sensitive: false }
  # validates :price, numericality: { greater_than_or_equal_to: 0 }
  # validates :description, presence: true, length: { minimum: 10 } 
  # This does not work: validates :sale_price, numericality: { less_than_or_equal_to: price }

# %w() is an array of strings
  validates :title, presence: true, uniqueness: { case_sensitive: true }, exclusion: { in: %w(Sony Apple Microsoft) }

  validate(:sale_less_than_price)
  

  # Setting the default price to 1 before validating makes sense. You just want a default value right before you validate its value.
  before_validation(:set_default_price_to_1)

  before_validation(:set_default_sale_price_to_price)

  # before_validation(:increment_save_hit_count)

  # Update Attribute: update_attribute(name, value) public
    # Updates a single attribute and saves the record. This is especially useful for boolean flags on existing records. Also note that

    # Validation is skipped.

    # Callbacks are invoked.

    # updated_at/updated_on column is updated if that column is available.

    # Updates all the attributes that are dirty in this object.

    # This method raises an +ActiveRecord::ActiveRecordError+ if the attribute is marked as readonly.


  

  before_save(:capitalize_product_title)

#Add a custom methods called search to the product model to search for a product with its title or description if it contains a specific word. For instance you should be able to do:

# Product.search("car")
# Which should return all the products that have the word car in it's title or description (case insensitive).

  def self.search(query)
    where("title ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%").order(title: :desc, description: :desc)
  end

# scope(:method_name_as_symbol, -> (arg) { where("title ILIKE ? OR description ILIKE ?", "%#{arg}%", "%#{arg}%") })
  # scope(:search, -> (query) { where("title ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%") })

# Challenge: Show the products that contain the searched word in their title before the ones that contain the searched word only in the description. For instance, if a product contains the word car in its title, it should before a product that only contains the word car only in the description.

# Approach: Do two or three separate searches that only have either the title or desciption.

  def tag_names
    self.tags.map{ |t| t.name }.join(",")
  end

  def tag_names=(rhs)
    self.tags = rhs.strip.split(/\s*,\s*/).map do |tag_name|
      Tag.find_or_initialize_by(name: tag_name)
    end
  end

  private

  def set_default_sale_price_to_price
    self.sale_price = price if sale_price.nil?
    # If you are writing to an attribute accessor, you
    # must prefix with `self.` which do not have to do
    # if you're just reading it instead.
    # self.view_count = 0 if self.view_count.nil?
    # self.view_count = self.view_count || 0
    # 👇 is syntax sugar for 👆
    # self.view_count ||= 0
    # The elusive or-equal will only assign to its left-hand side
    # if it is `nil`.
  end

  def set_default_price_to_1
    self.price ||= 1
  end

  def capitalize_product_title
    title.capitalize! # Remember title is an attr_accessor method
  end

  def sale_less_than_price
    if sale_price > price
    errors.add(:sale_price, "Sale price must be lower than price!")
    end
  end

  # def increment_save_hit_count # I think this should be limited to the instance, not the class. It doesn't work. Probably because all values are null instead of an integer.
  #   self.hit_count += 1
  #   # self.save!
  # end



end
