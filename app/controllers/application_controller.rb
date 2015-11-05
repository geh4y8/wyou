class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

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
end
