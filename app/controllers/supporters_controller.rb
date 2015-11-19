class SupportersController < ApplicationController

  before_action :authenticate_user!

  def index
    @campaign = Campaign.find(params[:campaign_id])
    @supporters = @campaign.supporters.all
  end

  def new
    @user = current_user.id
    @campaign = Campaign.find(params[:campaign_id])
    @supporter = @campaign.supporters.new
  end

  def create
    @campaign = Campaign.find(params[:campaign_id])
    @supporter = @campaign.supporters.new(:user_id => current_user.id)
    if @supporter.save
      redirect_to campaign_path(@campaign)
    else
      render :new
    end
  end

private
  def supporter_params
    params.require(:supporter).permit(:user_id, :campaign_id)
  end

end
