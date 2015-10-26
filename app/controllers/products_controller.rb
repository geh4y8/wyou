class ProductsController < ApplicationController

  before_action :authenticate_user!

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
    render :new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def show
    @product = Product.find(params[:id])
  end

  def edit
    @product = Product.find(params[:id])
    render :edit
  end

  def update
    @product = Product.find(params[:id])
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy
    redirect_to campaigns_path
  end

  def like

    @product = Product.find(params[:id])
    @product.liked_by current_user, :vote_scope => params['campaign_id']
    redirect_to :back
  end

  def dislike
    @product = Product.find(params[:id])
    @product.downvote_from current_user, :vote_scope => params['campaign_id']
    redirect_to :back
  end

private
  def product_params
    params.require(:product).permit(:name, :description, :retail_price, :image, :remove_image, :campaign_id)
  end
end
