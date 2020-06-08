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
  end

  def search
    @parents = Category.all.order("id ASC").limit(10)
    @products = Product.search(params[:keyword])
  end
end
