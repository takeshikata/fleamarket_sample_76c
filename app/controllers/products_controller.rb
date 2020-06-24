class ProductsController < ApplicationController
  before_action :set_category, only: [:new, :create]
  before_action :set_parent, except: [:delete]

  def index
    images = Image.select("id", "image", "product_id")
    @category_parents = Category.where(ancestry: nil).order("id ASC").limit(5)
    @category_products = Product.all

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
    @comment = Comment.new
    @comments = @product.comments.includes(:user).order(" created_at DESC ")
    @evaluation = Evaluation.where(product_id: @product.id)
    
    @evaluation_good_sum = Evaluation.where(user_id: @product.user_id, evaluation: 1)
    @evaluation_normal_sum = Evaluation.where(user_id: @product.user_id, evaluation: 2)
    @evaluation_bad_sum = Evaluation.where(user_id: @product.user_id, evaluation: 3)
    # binding.pry
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.user_id == current_user.id
      @product.destroy
      redirect_to root_path
    end
  end

  def purchase
    # showからのページ遷移アクション
    @user = User.find(current_user.id)
    @images = @product.images
    @image = @images.first

    if current_user.id == @product.user_id
      redirect_to root_path
    elsif @address.blank?
      redirect_to new_address_path(@user)
      # 売り切れの時に直打ち遷移しないようにする
    elsif @product.purchaser_id.present?
      redirect_to root_path
    end
  end

  def pay
    # 既に購入されていないか？ されていたらroot_path
    if @product.purchaser_id.present? && @product.user_id == current_user.id
      redirect_to root_path
    elsif @card.blank?
      # カード情報がなければ、カード登録画面に遷移
      redirect_to new_card_path
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.payjp_id)
      Payjp::Charge.create(
        amount: @product.price,
        customer: customer.id,
        currency: 'jpy'
      )
      # 売り切れになるので、productの情報をアップデートして売り切れにする
      if @product.update(purchaser_id: current_user.id)
        redirect_to action: 'show', id: @product.id
      else
        redirect_to action: 'show', id: @product.id
      end
    end
  end

  def get_category_children
      #選択された親カテゴリーに紐付く子カテゴリーの配列を取得
    @category_children = Category.find_by(id: "#{params[:parent_id]}", ancestry: nil).children
  end

  def get_category_grandchildren
    #binding.pry
      #選択された子カテゴリーに紐付く孫カテゴリーの配列を取得
    @category_grandchildren = Category.find("#{params[:child_id]}").children
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
  
  