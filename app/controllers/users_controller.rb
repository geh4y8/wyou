class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :admin_only, :except => [:show, :add_avatar, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to campaign_path(session[:campaign]), :notice => "User updated."
    else
      redirect_to campaign_path(session[:campaign]), :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  def add_avatar
    user = current_user
    render 'add_avatar'
  end

  def user_store
    @user = current_user
    @supporter = Supporter.where(:user_id => @user.id)
    @supporter.each do |supporter|

    end

    render 'campaigns/#{@campaign.id}/stores'
  end

  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role, :image, :remove_image, :image_id)
  end

end
