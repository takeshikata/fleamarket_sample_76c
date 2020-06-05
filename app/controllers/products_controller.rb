class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.create(product_params)
  end

  def edit
  end

  def update
  end

  def show
  end

  private
  def product_params
    params.require(:product).permit(:name, :introduction, :price)
  end
end
