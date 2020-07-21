class ProfilesController < ApplicationController
  before_action :set_parent

  def new
    @user = User.find(current_user.id)
    @profile = Profile.new
    @address = Address.where(user_id: current_user.id).first
  end

  def create
    product = Profile.create(profile_params)
  end


  def edit
    @user = User.find(params[:id])
    @profile = Profile.find(current_user.id)
    @address = Address.where(user_id: current_user.id).first
  end

  def update
    @user = User.find(params[:id])
    profile = Profile.find(current_user.id)
    profile.update(profile_params)
    redirect_to user_path
  end

  def set_parent
    @parents = Category.all.order("id ASC").limit(10)
  end

  private
  def profile_params
    params.require(:profile).permit(
      :first_name,
      :last_name,
      :first_name_kana,
      :last_name_kana,
      :birth_date,
      :introduction,
      :image
    )
  end
end
