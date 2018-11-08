class UserInfo < ApplicationRecord

  # def search(query)
  #   where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{query}%", "%%#{query}")
  # end

  scope(:search, -> (query) { where("first_name ILIKE ? OR last_name ILIKE ? OR email ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")})

end
