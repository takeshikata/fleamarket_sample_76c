class AddressesController < ApplicationController
  before_action :set_parent

  def new
    @user = User.find(current_user.id)
    @address = Address.new
    @profile = Profile.find(@user.id)
    # if @address.present?
    #   redirect_to edit_address_path(@user)
    # end
    
  end

  def create
    @user = User.find(current_user.id)
    @address = Address.create(address_params)
    # @address = Address.where(user_id: current_user.id).first
    # binding.pry
    if @address.save
      redirect_to users_path(@user)
    else
      render :new
    end
  end
  
  def edit
    @user = User.find(current_user.id)
    @address = Address.where(user_id: current_user.id).first
    @profile = Profile.find(@user.id)
    # unless @address.present?
    #   redirect_to new_address_path
    # end
  end

  def update
    @user = User.find(current_user.id)
    @address = Address.where(user_id: current_user.id).first

    if @address.update(address_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def set_parent
    @parents = Category.all.order("id ASC").limit(10)
  end

  private
  def address_params
    params.require(:address).permit(:last_name,
                                    :first_name,
                                    :last_name_kana,
                                    :first_name_kana, 
                                    :zip_code, 
                                    :prefecture, 
                                    :city, 
                                    :street_number,
                                    :apartment
    ).merge(user_id: current_user.id)
  end
end
