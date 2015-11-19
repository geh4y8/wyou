class StoresController < ApplicationController
  theme 'dmcs'

  before_action :authenticate_user!

  def index
    @campaign = Campaign.friendly.find(params[:campaign_id])
    if @campaign.products.first
      @products = @campaign.products.all
    end
    @cart = session[:cart]
    @cart_count = Store.products_in_cart(@cart)
  end
end
