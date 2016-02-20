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
end
