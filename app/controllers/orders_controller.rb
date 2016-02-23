class OrdersController < ApplicationController

  before_action :authenticate_user!
  before_filter :set_order, :except => [:create, :index, :new]

  def index
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @orders = @campaign.orders
  end

  def show

  end

  def new
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @order = @campaign.orders.new
    @cart = session[:cart]
  end

  def create
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @cart = session[:cart]
    @order = @campaign.orders.new(order_params.except(:order_total))
    if @order.save
      @cart.each do |product_id, quantity|
        @order.products << Product.find(product_id)
      end
      OrderMailer.order_confirmation_email(@order).deliver_later
      if @campaign.update!(:fund_amount => (@campaign.fund_amount - params[:order][:order_total].to_i))
        redirect_to campaign_path(@campaign)
      end
    end
  end

private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:campaign_id, :shipping_name, :shipping_street_address, :shipping_city, :shipping_state, :shipping_zip, :order_total)
  end
end
