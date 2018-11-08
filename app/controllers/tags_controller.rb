class TagsController < ApplicationController

  def show
    @tag = Tag.find_or_initialize_by(params[:tag])
    @products = @tag.products.order(title: :desc)
  end

  def index
    @tags = Tag.all

  end
end
