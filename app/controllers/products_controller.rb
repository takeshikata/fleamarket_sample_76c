class ProductsController < ApplicationController
  before_action :set_category, only: [:new, :create]
  before_action :set_parent, except: [:delete]

  def index
    @product_cat1 = Product.where(category_id: 200).limit(10).order(" created_at DESC ")
    @images = Image.select("id", "image", "product_id")
    @product_cat2 = Product.where(category_id: 19).limit(10).order(" created_at DESC ")
  end
  
  def new
    @product = Product.new
    @product.images.new
  end
  
  def create
    @product = Product.create!(product_params)
    # binding.pry
    # @image = Image.create(image_params)
    if @product.save
      redirect_to root_path
    else
      render :new
    end
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
  
  private
  def product_params
    params.require(:product).permit(
      :name,
      :introduction,
      :price,
      :category_id,
      :brand_id,
      :shipping_region_id,
      :shipping_payer_id,
      :preparation_term_id,
      :product_condition_id,
      images_attributes: [:image]
      ).merge(user_id: current_user.id)
    end
    
    
    def set_category
      @category_parent_array = Category.where(ancestry: nil).limit(13)
    end
    
    def set_parent
      @parents = Category.all.order("id ASC").limit(10)
    end
    
    
  end
  
  