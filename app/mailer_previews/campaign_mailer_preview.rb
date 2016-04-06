class CampaignMailerPreview
  def new_campaign_email
    CampaignMailer.new_campaign_email campaign = Campaign.find(1)
  end


  def invite_store_supporter
    CampaignMailer.invite_store_supporter campaign, user
  end
end
