class ProductsController < ApplicationController
  def index
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def show

    @product = Product.find(params[:id])
    @images = @product.images
    @image = @images.first
    @children = @product.category

  end
end
