class EvaluationsController < ApplicationController
  before_action :set_parent

  def new
    @product = Product.find(params[:product_id])
    @evaluation = Evaluation.new
    @user = User.find_by(id: @product.user_id) 
  end


  def create
    @product = Product.find(params[:product_id])
    @evaluation = Evaluation.create(evaluation_params)

    if @evaluation.save
      redirect_to product_path(@product)
    end
  end


  def set_parent
    @parents = Category.all.order("id ASC").limit(1)
  end

  private
  def evaluation_params
    params.require(:evaluation).permit(:evaluation).merge(user_id: @product.user_id, product_id: params[:product_id])
  end
end
