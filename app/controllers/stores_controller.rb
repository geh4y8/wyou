class StoresController < ApplicationController
  before_action :authenticate_user!

  def index

    @campaign = Campaign.friendly.find(params[:campaign_id])
    if @campaign.products.first
      @products = @campaign.products.all
    end

  end
end
