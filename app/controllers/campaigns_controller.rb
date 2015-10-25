class CampaignsController < ApplicationController


  before_action :authenticate_user!
  # before_action :admin_only, :except => :show

  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = Campaign.new
    render :new
  end

  def show
    @campaign = Campaign.find(params[:id])
    @results = @campaign.goal_percentage(@campaign)
    render :show
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      redirect_to campaigns_path
    else
      render :new
    end
  end

  def edit
    @campaign = Campaign.find(params[:id])
    render :edit
  end

  def update
    @campaign = Campaign.find(params[:id])
    if @campaign.update(campaign_params)
      redirect_to campaigns_path
    else
      render :edit
    end
  end

  def destroy
    @campaign = Campaign.find(params[:id])
    @campaign.destroy
    redirect_to campaigns_path
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name, :fund_goal, :patient_name, :patient_email, :patient_phone, :relationship, :owner_name, :self_purchase, :owner_email, :inform_patient_date)
  end
end
