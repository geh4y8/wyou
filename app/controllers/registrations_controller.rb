# controllers/registrations_controller.rb
class RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    "/attach_to_campaign"
  end
end
