class Api::V1::ProductsController < Api::ApplicationController

  before_action :authenticate_user!, only: [:create, :destroy, :update]
  # before_action :find_product, only: [:destroy, :update]
  before_action :authorize_user!, only: [:destroy, :update]

  def create
    product = Product.new product_params
    product.user = current_user

    if product.save
      render json: product
    else
      render json: { errors: product.errors.full_messages }
    end
  end


  def index
    products = Product.order(created_at: :desc)
    render json: products
  end

  def show
    # product = Product.find params[:id]
    render json: product
  end

  def destroy
    product.destroy
    head :ok
  end

  def update
    if product.update product_params
      render json: product
    else
      render json: { errors: product.errors.full_messages }
    end
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end

  def product
    @product ||= Product.find params[:id]
  end

  def authorize_user!
    render(json: { status: 401 }, status: 401) unless can?(:crud, product)

  end


end
