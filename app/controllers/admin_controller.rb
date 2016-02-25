class AdminController < ApplicationController
  before_action :authenticate_user!, :except => :show

  def index
    @orders = Order.last(5).reverse
  end

  def orders
    @orders = Order.all
    render 'orders'
  end

  def products
    @products = Product.all
    @categories = Category.all
    render 'products'
  end

  def campaigns
    @campaigns = Campaign.all
    render 'campaigns'
  end

  def assign_category_options
    render 'assign_category_options'
  end
end
