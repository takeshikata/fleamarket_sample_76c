class UsersController < ApplicationController
  before_action :set_parent

  def index
    @user = User.find(current_user.id)
    @products = @user.products
    @address = Address.where(user_id: current_user.id).first
    # if Address.user_id == @user.id
    
  end

  def show
    @product = Product.find_by(user_id: params[:id])
    @products = Product.where(user_id: params[:id])

    if @product
      d_evaluations = Evaluation.select(:user_id, :product_id, :evaluation).distinct

      @evaluation_good_sum, @evaluation_normal_sum, @evaluation_bad_sum = 0, 0, 0
      @products.each do |product|
        @evaluation_good_sum += d_evaluations.where(evaluation: :good, product_id: product.id).where.not(user_id: product.user_id).count
        @evaluation_normal_sum += d_evaluations.where(evaluation: :normal, product_id: product.id).where.not(user_id: product.user_id).count
        @evaluation_bad_sum += d_evaluations.where(evaluation: :bad, product_id: product.id).where.not(user_id: product.user_id).count
      end
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
