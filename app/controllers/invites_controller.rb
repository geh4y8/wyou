class InvitesController < ApplicationController

  def index
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @invites = @campaign.invites
  end

  def new
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @url = "wyou.co/users/sign_up?campaign_code=#{@campaign.campaign_code}"
    @invite = @campaign.invites.new
  end

  def create
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @invite = @campaign.invites.new(invite_params)
    if @invite.save
      InviteMailer.invite_contributor_email(@invite).deliver
      flash[:success] = "You have successfully invited #{@invite.contributor_name}"
      redirect_to campaign_path(@campaign)
    end
  end

  private

  def invite_params
    params.require(:invite).permit(:contributor_name, :contributor_email, :contributor_message)
  end
end
