class CategoriesController < ApplicationController

  before_action :set_parent

  def index
    @category_parents = Category.where(ancestry: nil).order("id ASC").limit(2)
    @category_products = Product.all
    
    images = Image.select("id", "image", "product_id")
  end

  private
  def set_parent
    @parents = Category.all.order("id ASC").limit(10)
  end

end
