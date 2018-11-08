class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :full_name

  has_many :products


  
end
