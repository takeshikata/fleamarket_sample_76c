class EvaluationsController < ApplicationController
  before_action :set_parent

  def create
    # binding.pry
    @product = Product.find(params[:product_id])

    if params[:evaluation].to_i == 1
      @evaluation = Evaluation.new(user_id: current_user.id, product_id: @product.id, evaluation: :good)
    elsif params[:evaluation].to_i == 2
      @evaluation = Evaluation.new(user_id: current_user.id, product_id: @product.id, evaluation: :normal)
    elsif params[:evaluation].to_i == 3
      @evaluation = Evaluation.new(user_id: current_user.id, product_id: @product.id, evaluation: :bad)
    end
    @evaluation.save
    redirect_to product_path(params[:product_id])
  end

  def set_parent
    @parents = Category.all.order("id ASC").limit(1)
  end
end
