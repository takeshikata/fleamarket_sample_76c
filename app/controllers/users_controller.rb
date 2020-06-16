class UsersController < ApplicationController
  before_action :set_parent

  def index
    @user = User.find(current_user.id)
    @products = @user.products
  end

  def show
    @product = Product.find_by(user_id: params[:id])

    if @product
      d_evaluations = Evaluation.select(:user_id, :product_id, :evaluation).distinct
      @evaluation_good_count = d_evaluations.where(evaluation: :good, product_id: @product.id).where.not(user_id: @product.user_id).count
      @evaluation_normal_count = d_evaluations.where(evaluation: :normal, product_id: @product.id).where.not(user_id: @product.user_id).count
      @evaluation_bad_count = d_evaluations.where(evaluation: :bad, product_id: @product.id).where.not(user_id: @product.user_id).count
    end
  end

  def destroy
    # session[:user_id] = nil
    # flash[:notice] = "ログアウトしました"
    # redirect_to root_path
  end

  def log_out
    @user = User.find(current_user.id)
  end



  def set_parent
    @parents = Category.all.order("id ASC").limit(10)
  end
end
