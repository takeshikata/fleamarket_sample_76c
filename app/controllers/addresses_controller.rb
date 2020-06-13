class AddressesController < ApplicationController
  before_action :set_parent

  def edit
    @user = User.find(current_user.id)
  end

  def update
  end

  def set_parent
    @parents = Category.all.order("id ASC").limit(10)
  end
end
