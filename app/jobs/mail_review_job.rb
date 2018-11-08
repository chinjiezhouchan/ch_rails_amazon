class MailReviewJob < ApplicationJob
  queue_as :default

  def perform(review)

    ReviewMailer.notify_product_owner(review)

    
    # Do something later
  end
end
