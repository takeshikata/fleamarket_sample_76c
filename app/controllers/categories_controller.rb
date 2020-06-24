class CategoriesController < ApplicationController

  before_action :set_parent

  def index
    # 衣類専門のサイト仕様するためにlimit(2)で指定
    @category_parents = Category.where(ancestry: nil).order("id ASC").limit(3)
    @category_products = Product.all
    
    images = Image.select("id", "image", "product_id")
  end

  def show

    @category = Category.find(params[:id])
    @category_products = Product.all
    images = Image.select("id", "image", "product_id")
    # binding.pry

  end

  private
  def set_parent
    @parents = Category.all.order("id ASC").limit(10)
  end

end
