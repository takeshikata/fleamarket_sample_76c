class ProfilesController < ApplicationController
  before_action :set_parent

  def new
    @user = User.find(current_user.id)
    @profile = Profile.new
  end

  def create
    product = Profile.create(profile_params)
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
