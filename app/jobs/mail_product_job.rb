class MailProductJob < ApplicationJob
  queue_as :default

  def perform(product)
    # Do something later


    ProductMailer.give_owner_their_product_page(product)
  end
end
