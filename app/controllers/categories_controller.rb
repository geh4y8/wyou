class CategoriesController < ApplicationController

before_action :authenticate_user!

  def index
    @categories = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to '/admin/products'
    else
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @category.update(category_params)
      redirect_to '/admin/products'
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to '/admin/products'
  end

  def assign_products
    @category = Category.find(params[:category_id])
    @product = Product.find(params[:category][:products])
    @category.products << @product if !@category.products.include?(@product)
    redirect_to '/admin/products'
  end

  private

  def set_category
    @category = Category.friendly.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :product_id, :category_id, :category)
  end



end
