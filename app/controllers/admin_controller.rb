class AdminController < ApplicationController
  before_action :authenticate_user!, :except => :show

  def index
    @orders = Order.last(5).reverse
  end
end
