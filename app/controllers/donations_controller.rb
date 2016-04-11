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

  def show
    @campaign = Campaign.friendly.find(params[:campaign_id])
  end

  def create
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @donation = @campaign.donations.new(donation_params.except(:email))
    # customer = Stripe::Customer.create email: donation_params[:email],
    #                                    card: @donation.card_token

    Stripe::Charge.create({#customer: customer.id,
                          amount: (@donation.donation_amount * 0.8 * 100).to_i,
                          description: "c-#{@campaign.id}",
                          currency: 'usd',
                          source: @donation.card_token,
                          application_fee: (@donation.donation_amount * 0.2 * 100).to_i
                          }, {:stripe_account => ENV['STRIPE_ACCOUNT']})

    if @donation.save
      if @campaign.update(:fund_amount => (@campaign.fund_amount + (@donation.donation_amount * 0.8)))
        if @campaign.supporters.where(:user_id => current_user.id).empty?
          @campaign.supporters.new(:user_id => current_user.id).save
        end
        DonationMailer.new_donation_email(@campaign, current_user, @donation.donation_amount).deliver_later
        DonationMailer.confirm_donation_email(@campaign, current_user, @donation.donation_amount).deliver_later
        if @campaign.private?
          redirect_to campaign_stores_path(@campaign)
        else
          redirect_to campaign_path(@donation.campaign)
        end
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
