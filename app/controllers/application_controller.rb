class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    redirect_to root_url
  end

  def after_sign_in_path_for(resource)
    if params[:redirect_to].present?
      store_location_for(resource, params[:redirect_to])
    # elsif request.referer == new_session_url
    #   super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  def after_sign_up_path_for(resource)
    if params[:redirect_to].present?
      store_location_for(resource, params[:redirect_to])
    # elsif request.referer == new_session_url
    #   super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :image, :image_id) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :current_password, :image, :image_id) }
    end


end
