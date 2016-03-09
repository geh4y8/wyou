class OrdersController < ApplicationController

  before_action :authenticate_user!
  before_filter :set_order, :except => [:create, :index, :new, :assign_shipped, :add_shipping_confirmation, :show]

  def index
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @orders = @campaign.orders
  end

  def show
    @order = Order.find(params[:id])
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

  def add_shipping_confirmation
    @order = Order.find(params[:order_id])
    render 'add_shipping_confirmation'
  end

  def assign_shipped
    @order = Order.find(params[:order_id])
    @order.update(shipped: true, shipping_confirmation: params[:order][:shipping_confirmation], additional_notes: params[:order][:additional_notes])
    OrderMailer.order_shipment_confirmation_email(@order).deliver_later
    redirect_to '/admin/orders'
  end

private
  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:campaign_id, :shipping_name, :shipping_street_address, :shipping_city, :shipping_state, :shipping_zip, :order_total, :order_id, :additional_notes)
  end
end
