class FaqController < ApplicationController
  theme 'dmcs'

  def index
    @campaign = Campaign.find(session[:campaign_id])
  end

end
