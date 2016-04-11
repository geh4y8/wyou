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
    campaign = User.find(resource.id).campaigns.first
    if campaign.private?
      campaign_stores_path(campaign)
    else
      campaign_path(campaign)
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
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :email, :password, :image, :image_id, :remove_image, :campaign_code, :is_patient) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :current_password, :password, :image, :image_id, :remove_image, :is_patient, :managed_account, :managed_name, :managed_email, :preferred_name, :zip_code, :gender, :symptoms, :diagnosis, :treatment_plan, :treatment_schedule, :item_needed_by, :normal_size, :plus_size, :petite_size, :other_notes, :dob) }
    end


end
