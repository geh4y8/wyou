class ProductsController < ApplicationController

  before_action :authenticate_user!
  before_filter :set_product, :except => [:index, :new, :create]

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
  end

  def edit
    render :edit
  end

  def update
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  def like
    @product.liked_by current_user, :vote_scope => params['campaign_id']
    current_user.likes @product
    redirect_to :back
  end

  def dislike
    @product.downvote_from current_user, :vote_scope => params['campaign_id']
    current_user.dislikes @product
    redirect_to :back
  end

private
  def set_product
    @product = Product.friendly.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :retail_price, :image, :remove_image, :campaign_id)
  end
end
