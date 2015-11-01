class CampaignMailer < ApplicationMailer
  default from: 'notifications@wyou.co'

  def new_campaign_email(user, campaign)
    @user = user
    @campaign = campaign
    @url = "wyoutest1.herokuapp.com/#{@campaign.id}"
    mail(
      to: "#{user.email}",
      subject: "[w/you] New Campaign Created!")
  end
end
