class StoresController < ApplicationController
  before_action :authenticate_user!

  def index
    @campaign = Campaign.find(params[:campaign_id])
    @products = @campaign.products.all
  end
end
