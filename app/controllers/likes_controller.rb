class LikesController < ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy]
  
  # Before 
  before_action :find_review, only: [:create]

  before_action :authorize_user!, only: [:create]

  def create

    # 
    review = Review.find(params[:review_id])
    like = Like.new(
      user: current_user,
      review: review
    )

    if review.save
      flash[:success] = "Liked the review!"
    else 
      flash[:danger] = like.errors.full_messages.join(", ")
    end

    redirect_to product_path(review.product)
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy

    flash[:success] = "Unliked successfully!"

    redirect_to product_path(like.review.product)
  end

  private

  def find_review
    review = Review.find params[:review_id]
  end

  def authorize_user!
    unless can?(:like, review)
      flash[:danger] = "Be cool. Don't like yourself."
      redirect_to product_path(review.product)
  end

end
