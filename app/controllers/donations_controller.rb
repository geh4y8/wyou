class DonationsController < ApplicationController

  before_action :authenticate_user!

  def index
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @donations = @campaign.donations.all
  end

  def new
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @donation = @campaign.donations.new
  end

  def create
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @donation = @campaign.donations.new(donation_params.except(:email))
    customer = Stripe::Customer.create email: donation_params[:email],
                                       card: @donation.card_token

    Stripe::Charge.create customer: customer.id,
                          amount: @donation.donation_amount * 100,
                          description: @campaign.name,
                          currency: 'usd'
    if @donation.save
      if @campaign.update(:fund_amount => (@campaign.fund_amount + @donation.donation_amount))
        redirect_to campaign_path(@donation.campaign)
      end
    else
      render :new
    end
  end

private
  def donation_params
    params.require(:donation).permit(:donation_amount, :user_id, :email, :card_token)
  end

end
