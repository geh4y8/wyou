class CampaignsController < ApplicationController
  theme 'kickstars'

  before_action :authenticate_user!, :except => :show
  before_filter :set_campaign, :except => [:index, :new, :create, :add_product, :assign_product, :possible_campaigns, :assign_category_options, :assign_category, :invite_store_supporter, :send_store_invite, :possible_campaigns2, :switch_campaign, :join_existing_campaign]
  # before_action :admin_only, :except => :show

  def index
    @campaigns = Campaign.all
  end

  def new
    @campaign = Campaign.new
  end

  def show
    @campaign_owner = User.where('email = :email', { email: @campaign.owner_email}).first
    @user_is_campaign_owner = @campaign.owner_email == current_user.email ? true : false
    @special_not_available = @campaign.donations.any?{|donation| donation.special == true}
    @user = current_user
    @results = @campaign.goal_percentage(@campaign)
    @supporter_results = @campaign.supporters_image_count(@campaign)
    session[:campaign_id] = @campaign.id
  end

  def create
    @campaign = Campaign.new(campaign_params.merge(campaign_code: create_unique_code))
    if @campaign.save
      current_user.update!(campaign_code: @campaign.campaign_code)
      add_new_campaign
      CampaignMailer.new_campaign_email(@campaign).deliver_later
      CampaignMailer.new_campaign_recipient_email(@campaign).deliver_later
      client = Nexmo::Client.new
      client.send_message(from: '12765973538', to: '1' + @campaign.patient_phone, text:
        "#{@campaign.owner_name} has created a campaign on w/you for you!  Go to your account: wyou.co/users/sign_up?campaign_code=#{@campaign.campaign_code}&name=#{@campaign.patient_name}&email=#{@campaign.patient_email}" )
      if current_user.is_patient? && @campaign.private?
        redirect_to campaign_stores_path(@campaign)
      elsif !@campaign.private? && !current_user.is_patient?
        redirect_to campaign_path(@campaign)
      else
        render 'campaign_created', locals: { campaign: @campaign }
      end
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
    flash[:message] = 'Campaign Deleted'
    redirect_to '/admin/campaigns'
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

  def possible_campaigns
    add_new_campaign
    @current_campaigns = current_user.campaigns
    if @current_campaigns.count == 0
      redirect_to new_campaign_path
    elsif @current_campaigns.count == 1 && current_user.is_patient? && @current_campaigns.first.supporters.count < 3
      @campaign = @current_campaigns.first
      render 'campaign_created', locals: { campaign: @campaign }
    elsif @current_campaigns.count == 1
      redirect_to campaign_path(@current_campaigns.first.id)
    else
      render :possible_campaigns
    end
  end

  def possible_campaigns2(current_campaigns)
    @current_campaigns = current_campaigns
    # render :possible_campaigns2
  end

  def assign_category
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @category = Category.find(params[:campaign][:category])
    @campaign.update(category_id: @category.id)
    redirect_to '/admin/campaigns'
  end

  def assign_category_options
    @campaign = Campaign.friendly.find(params[:campaign_id])
    render 'assign_category_options'
  end

  def invite_store_supporter
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @supporters = @campaign.supporters
    render 'invite_store_supporter'
  end

  def send_store_invite
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @supporter = @campaign.supporters.where(user_id: params[:supporters])
    @campaign.store_supporters.create(user_id: params[:supporters], campaign_id: params[:campaign_id])
    CampaignMailer.invite_store_supporter(@campaign, User.find(params[:supporters])).deliver_later
    redirect_to campaign_stores_path(@campaign)
  end

  def switch_campaign
    @user = current_user
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @current_campaigns = Supporter.where(user_id: @user.id)
    render 'switch_campaign'
  end

  def join_existing_campaign
    if @campaign = Campaign.find_by(campaign_code: params[:campaign_code])
      if !@campaign.supporters.where(user_id: current_user.id).present?
        @campaign.supporters.create!(user_id: current_user.id)
      end
      redirect_to campaign_path(@campaign)
    else
      flash[:message] = "We couldn't find a campaign matching that code, please try again."
      redirect_to :back
    end
  end

  private

  def set_campaign
    @campaign = Campaign.friendly.find(params[:id])
  end

  def add_new_campaign
    if Campaign.where(campaign_code: current_user.campaign_code).first
      campaign = Campaign.where(campaign_code: current_user.campaign_code).first
      if !campaign.supporters.where(user_id: current_user.id).present?
        campaign.supporters.create!(user_id: current_user.id)
      end
    end
  end

  def create_unique_code
    begin
      unique_code = SecureRandom.hex(2)
    end while Campaign.exists?(:campaign_code => unique_code)
    unique_code
  end

  def campaign_params
    params.require(:campaign).permit(:name, :fund_goal, :patient_name, :patient_email, :patient_phone, :relationship, :owner_name, :self_purchase, :owner_email, :inform_patient_date, :product_id, :campaign_id, :image, :remove_image, :campaign_description, :provide_description, :private, :campaign_code, :donation_alerts)
  end
end
