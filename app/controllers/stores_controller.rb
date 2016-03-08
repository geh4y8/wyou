class StoresController < ApplicationController
  theme 'dmcs'

  before_action :authenticate_user!

  def index
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @products = @campaign.category.products
    @cart = session[:cart]
    @cart_count = Store.products_in_cart(@cart)
    @invitable = @campaign.store_supporters.count < 4
    session[:campaign_id] = @campaign.id
  end

  def possible_stores
    @user = current_user
    @supporter = Supporter.where(:user_id => @user.id)
    if (@supporter.size > 1)
      render 'possible_stores'
    else
      @campaign = Campaign.find(@supporter.first.campaign_id)
      redirect_to controller: 'stores', action: 'index', :campaign_id => @campaign.id
    end
  end
end
