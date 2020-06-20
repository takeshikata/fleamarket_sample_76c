class ProductsController < ApplicationController
  require "payjp"
  before_action :set_category, only: [:new, :create, :update, :edit]

  before_action :set_parent,   except: [:delete]
  before_action :set_product,  only: [:edit, :show, :update, :purchase, :pay]
  before_action :set_address,  only: [:purchase, :pay]
  before_action :set_card,     only: [:purchase, :pay]


  def index
    @product_cat1 = Product.where(category_id: 3).limit(10).order(" created_at DESC ")
    @images = Image.select("id", "image", "product_id")
    @product_cat2 = Product.where(category_id: 19).limit(10).order(" created_at DESC ")
  end

  def new
    @product = Product.new
    @product.images.new
    #@images = @product.build_images
    @category_parent_array = Category.where(ancestry: nil).order(id: "ASC")
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
    grandchild_category = @product.category
    child_category = grandchild_category.parent
    parent_category = grandchild_category.root
    # binding.pry

    @category_parent_array = []
    Category.where(ancestry: nil).each do |parent|
      @category_parent_array << parent.name
    end

    @category_children_array = []
    Category.where(ancestry: child_category.ancestry).each do |children|
      @category_children_array << children
    end

    @category_grandchildren_array = []
    Category.where(ancestry: grandchild_category.ancestry).each do |grandchildren|
      @category_grandchildren_array << grandchildren
    end
  end

  def update
    if
      product = Product.find(params[:id])
      product.update(edit_product_params)
      redirect_to root_path
    else
      render 'edit'
    end
  end

  def destroy

  end

  def show
    @product = Product.find(params[:id])
    @images = @product.images
    @image = @images.first
    @children = @product.category
    @comment = Comment.new
    @comments = @product.comments.includes(:user)

    d_evaluations = Evaluation.select(:user_id, :product_id, :evaluation).distinct
    @evaluation_good_count = d_evaluations.where(evaluation: :good, product_id: @product.id).where.not(user_id: @product.user_id).count
    @evaluation_normal_count = d_evaluations.where(evaluation: :normal, product_id: @product.id).where.not(user_id: @product.user_id).count
    @evaluation_bad_count = d_evaluations.where(evaluation: :bad, product_id: @product.id).where.not(user_id: @product.user_id).count
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

    if @address.blank?
      redirect_to new_address_path(@user)
    end
  end

  def pay
    # 既に購入されていないか？ されていたらroot_path
    if @product.purchaser_id.present?
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

  def search
    @products = Product.search(params[:keyword])
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
    @parents = Category.all.order(id: "ASC").limit(10)
  end

  def set_product
    @product = Product.find(params[:id])
  end


  def set_address
    @address = Address.where(user_id: current_user.id).first
  end

  def set_card
    @card = Card.where(user_id: current_user.id).first
  end


  def edit_product_params
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
    )
  end
end
