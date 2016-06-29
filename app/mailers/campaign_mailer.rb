class CampaignMailer < ApplicationMailer
  default from: 'notifications@wyou.co'

  def new_campaign_email(campaign)
    @campaign = campaign
    @url = "wyou.co/campaigns/#{@campaign.id}"
    mail(
      to: "#{@campaign.owner_email}",
      subject: "[w/you] New Campaign Created!")
  end

  def invite_store_supporter(campaign, user)
    @campaign = campaign
    @user = user
    @url = "wyou.co/campaigns/#{@campaign.id}/stores"
    mail(
      to: user.email,
      subject: "[w/you] You have been invited!")
  end

  def new_campaign_recipient_email(campaign)
    @campaign = campaign
    @url = "wyou.co/users/sign_up?campaign_code=#{@campaign.campaign_code}&name=#{@campaign.patient_name}&email=#{@campaign.patient_email}"
    mail(
      to: @campaign.patient_email,
      subject: "[w/you] Someone has created a campaign for you!")
  end

  def additional_patient_information_email(user)
    @user = user
    mail(
      to: 'annie@wyou.co',
      subject: "[w/you] Campaign recipient additional information received!")
  end
end
