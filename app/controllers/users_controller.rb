class UsersController < ApplicationController
  before_action :set_parent

  def index
    if user_signed_in?
      @address = Address.where(user_id: current_user.id).first
      @user = User.find(current_user.id)
      @products = @user.products
      @address = Address.where(user_id: current_user.id).first
      @profile = Profile.find(@user.id)
      @product_sell = Product.where(user_id: current_user.id, purchaser_id: nil)
      @product_selled = Product.where(user_id: current_user.id).where.not(purchaser_id: nil)
      @product = Product.find_by(user_id: params[:id])
      @evaluation_good_sum = Evaluation.where(user_id: current_user.id, evaluation: 1)
      @evaluation_normal_sum = Evaluation.where(user_id: current_user.id, evaluation: 2)
      @evaluation_bad_sum = Evaluation.where(user_id: current_user.id, evaluation: 3)
    else
      redirect_to root_path
    end
  #   binding.pry
  end
  
  def show
    if user_signed_in?
      @user = User.find(current_user.id)
      @product = Product.find_by(user_id: params[:id])
      @products = Product.where(user_id: params[:id])
      @product_sell = Product.where(user_id: params[:id], purchaser_id: nil)
      @product_selled = Product.where(user_id: params[:id]).where.not(purchaser_id: nil)
      @profile = Profile.find(params[:id])   
      @evaluation_good_sum = Evaluation.where(user_id: current_user.id, evaluation: 1)
      @evaluation_normal_sum = Evaluation.where(user_id: current_user.id, evaluation: 2)
      @evaluation_bad_sum = Evaluation.where(user_id: current_user.id, evaluation: 3)
    else
      redirect_to root_path
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

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: current_user.id)
  end

  def history
    @products = Product.where(purchaser_id: params[:id])
  end


  def set_parent
    @parents = Category.all.order("id ASC").limit(10)
  end
end
