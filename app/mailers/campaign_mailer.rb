class CampaignMailer < ApplicationMailer
  default from: 'notifications@wyou.co'

  def new_campaign_email(campaign)
    @campaign = campaign
    @url = "wyoutest1.herokuapp.com/#{@campaign.id}"
    mail(
      to: "#{@campaign.owner_email}",
      subject: "[w/you] New Campaign Created!")
  end
end
