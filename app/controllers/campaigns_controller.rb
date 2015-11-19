class CampaignsController < ApplicationController
  theme 'kickstars'

  before_action :authenticate_user!, :except => :show
  before_filter :set_campaign, :except => [:index, :new, :create, :add_product, :assign_product]
  # before_action :admin_only, :except => :show

  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = Campaign.new
  end

  def show
    @campaign_owner = User.where('email = :email', { email: @campaign.owner_email}).first
    @user = current_user
    @results = @campaign.goal_percentage(@campaign)
    @supporter_results = @campaign.supporters_image_count(@campaign)
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      CampaignMailer.new_campaign_email(@campaign).deliver_later
      redirect_to campaigns_path
    else
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @campaign.update(campaign_params)
      redirect_to campaigns_path
    else
      render :edit
    end
  end

  def destroy
    @campaign.destroy
    redirect_to campaigns_path
  end

  def add_product
    @campaign = Campaign.friendly.find(params[:campaign_id])
    render :add_product
  end

  def assign_product
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @product = Product.find(params[:campaign][:products])
    @campaign.products << @product
    redirect_to campaign_stores_path
  end

  private

  def set_campaign
     @campaign = Campaign.friendly.find(params[:id])
  end

  def campaign_params
    params.require(:campaign).permit(:name, :fund_goal, :patient_name, :patient_email, :patient_phone, :relationship, :owner_name, :self_purchase, :owner_email, :inform_patient_date, :product_id, :campaign_id, :image, :remove_image, :campaign_description, :provide_description)
  end
end
