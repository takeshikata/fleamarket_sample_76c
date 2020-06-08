class ProductsController < ApplicationController
  def index
  end

  def new
    @product = Product.new
    @image = Image.new
  end

  def create
    # binding.pry
    @product = Product.create(product_params)
    @image = Image.create(image_params)
    # @parents = Category.all.order("id ASC").limit(13)
    # if @product.save
    #   redirect_to root_path
    # else
    #   render :new
    # end
  end

  def edit
  end

  def update
  end

  def show
  end

  private
  def product_params
    params.require(:product).permit(:name, :introduction, :price, :category_id, :brand_id, :shipping_payer_id, :shipping_region_id, :product_condition_id, :preparation_term_id)
  end

  def image_params
    params.require(:image).permit(:image)
  end

  # @product.images.build
  # # 


end
