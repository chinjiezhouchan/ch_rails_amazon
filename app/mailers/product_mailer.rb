class ProductMailer < ApplicationMailer

  def give_owner_their_product_page(product)
    @product = product
    @creator = product.user
    
    mail(
      to: @creator.email,
      subject: "Congratulations, #{product.user.first_name}, for making a new product!"
    )
  end
end
