class ProfilesController < ApplicationController
  before_action :set_parent

  def new
  end

  def create
  end


  def edit
    @user = User.find(current_user.id)
    @address = Address.where(user_id: current_user.id).first
  end

  def update
  end

  def set_parent
    @parents = Category.all.order("id ASC").limit(10)
  end
end


# @profile = Profile.find(current_user.id)
# @address = Address.find(user_id: current_user.id)
