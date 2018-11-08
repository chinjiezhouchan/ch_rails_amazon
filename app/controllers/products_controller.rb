class ProductsController < ApplicationController

  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  before_action :find_product, only: [:edit, :destroy]

  before_action :authorize_user!, only: [:edit, :destroy]

  def new
    
    @product = Product.new
  end

  def create
    @product = Product.new product_params
    @product.user = current_user

    if @product.save
      if @product.user.present? # for belongs_to {optional: true}
        MailProductJob.perform_later(@product)
      end

      redirect_to products_path(@product.id)
    else
      render :new
    end
  end

  def show
    @product = Product.find params[:id]
    @reviews = @product.reviews.order(created_at: :desc)
    
    @review = Review.new 
    # @product_user = User.find(params[:user])
  end

  def index
    if params[:tag]
      @tag = Tag.find_or_initialize_by(name: params[:tag])
      @products = @tag.products.order(created_at: :desc)
    else 
      @products = Product.limit(20).order(created_at: :desc)
    end
  end

  def destroy
    @product = Product.find params[:id]
    @product.destroy

    redirect_to products_path
  end

  def edit
    
  end

  def update
    @product = Product.find params[:id]

    if @product.update product_params
      redirect_to product_path(@product.id)
    else
      render :edit
    end
    
  end

  private

  def find_product
    @product = Product.find params[:id]
  end

  def authorize_user!
    unless can? :ed_del, @product
      flash[:danger] = "Access Denied"

      redirect_to home_path
    end
  end

  def product_params
    params.require(:product).permit(:title,:description,:price, :tag_names);
  end

end
