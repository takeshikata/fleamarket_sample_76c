class ProductsController < ApplicationController
  def index
    @product_cat1 = Product.where(category_id: 1).limit(10).order(" created_at DESC ")
    @images = Image.select("id", "image", "product_id")
    @product_cat2 = Product.where(category_id: 2).limit(10).order(" created_at DESC ")
    @parents = Category.all.order("id ASC").limit(10)
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
  end
end

