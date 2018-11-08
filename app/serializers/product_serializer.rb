class ProductSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :price, :created_at, :updated_at, :sale_price, :hit_count

  belongs_to :user, key: :seller
  has_many :reviews
  
end
