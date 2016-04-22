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
      if @user.is_patient?
        CampaignMailer.additional_patient_information_email(@user).deliver_later
      end
      if @user.campaign_code.present?
        redirect_to campaign_path(Campaign.find_by(campaign_code: @user.campaign_code))
      else @user.campaigns.empty?
        redirect_to attach_to_campaign_path
      end
    else
      redirect_to user_path(@user), :alert => "Unable to update user."
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
    params.require(:user).permit(:role, :is_patient, :campaign_code, :image, :remove_image, :image_id, :managed_account, :managed_name, :managed_email, :preferred_name, :zip_code, :gender, :symptoms, :diagnosis, :treatment_plan, :treatment_schedule, :item_needed_by, :normal_size, :plus_size, :petite_size, :other_notes, :dob)
  end

end
