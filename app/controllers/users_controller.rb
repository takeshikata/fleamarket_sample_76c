class UsersController < ApplicationController
  before_action :set_parent

  def index
    @user = User.find(current_user.id)
    @products = @user.products
  end

  def show
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
