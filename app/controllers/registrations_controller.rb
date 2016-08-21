# controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    "/add_avatar"
  end

  # def after_sign_in_path_for(resource)
  #   campaign = User.find(resource.id).campaigns.first
  #   binding.pry
  #   redirect_to campaign_path(campaign)
  # end

  def sign_up_params
    params.require(:user).permit(:name, :email, :password, :image, :image_id, :remove_image, :campaign_code, :is_patient)
  end

  protected

  def update_resource(resource, params)
    binding.pry
    resource.update_without_password(sign_up_params)
  end
end
