class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :basic_auth, if: :production?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    root_path
  end

  protected
  def configure_permitted_parameters
    added_attrs = [:nickname, profile_attributes: [:first_name, :last_name, :first_name_kana, :last_name_kana, :first_name, :birth_year, :birth_month, :first_name, :birth_date]]
    devise_parameter_sanitizer.permit(:sign_up, keys: added_attrs)
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  def production?
    Rails.env.production?
  end
end
