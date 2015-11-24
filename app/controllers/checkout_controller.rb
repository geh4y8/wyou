class CheckoutController < ApplicationController
  before_action :authenticate_user!
  theme 'dmcs'

  def index
    @cart = session[:cart]
  end
end
