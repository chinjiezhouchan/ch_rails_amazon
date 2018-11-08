class ReviewsController < ApplicationController

  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :find_review, only: [:update, :edit, :destroy]
  before_action :authorize_user!, only: [ :edit, :update, :destroy]

  def create
    # render json: params

    # @review will be a new model instance object with the params from the form submission.
    @review = Review.new review_params
    @review.user = current_user

    # :product_id comes from the URL. I thought it came from the form submission of the new Review, but that form submission doesn't yet have a product_id associated. Rails is great because params includes the URL.
    @product = Product.find params[:product_id]

    # Associate the product with the review. I think this actually adds the correct foreign key.
    @review.product = @product

    if @review.save
      if @review.user.present?
        MailReviewJob.perform_later(@review)
      end
      redirect_to product_path(@product.id)
    else
      # Call up all the reviews, and render the show page for that product again.
      @reviews = @product.reviews.order(created_at: :desc)

      # Syntax of render is products folder/ name of html.erb file
      render "products/show"
    end

  end

  def edit
    @review = Review.find params[:id]
    @product = Product.find params[:product_id]
  end

  def update
    
    if @review.update review_params
      redirect_to product_path params[:product_id]
    else
      render :edit
    end

  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy

    redirect_to products_path
  end


  private

  def authorize_user!
    unless can? :ed_del, @review
      flash[:danger] = "Access Denied"

      redirect_to home_path
    end
  end

  def find_review
    @review = Review.find params[:id]
  end

  def review_params
    params.require(:review).permit(:rating,:body)
  end

end
