# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def new
    @parents = Category.all.order("id ASC").limit(1)
    @user = User.new
    @profile = @user.build_profile
  end
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  def destroy
    # session[:user_id] = nil
    # flash[:notice] = "ログアウトしました"
    # redirect_to root_path
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
