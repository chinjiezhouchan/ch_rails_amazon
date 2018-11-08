class ReviewMailer < ApplicationMailer

  def notify_product_owner(review)

    @review = review

    mail(
      to: @review.product.user.email,
      subject: "#{review.user.first_name} reviewed your #{review.product.title}!"
    )
    
  end
end
