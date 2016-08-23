class DonationMailer < ApplicationMailer
  default from: 'notifications@wyou.co'

  def confirm_donation_email(campaign, user, donation_amount)
    @campaign = campaign
    @user = user
    @donation_amount = donation_amount
    @url = "wyou.co/campaigns/#{@campaign.id}"
    mail(
      to: "#{@user.email}",
      subject: "[w/you] Donation Receipt")
  end

  def new_donation_email(campaign, user, donation_amount)
    @campaign = campaign
    @user = user
    @donation_amount = donation_amount
    if User.find_by(email: @campaign.patient_email)
      @url = "wyou.co/campaigns/#{@campaign.id}"
    else
      @url = "wyou.co/users/sign_up?campaign_code=#{@campaign.campaign_code}&name=#{@campaign.patient_name}&email=#{@campaign.patient_email}"
    end
    mail(
      to: @campaign.patient_email,
      subject: "[w/you] Donation Received!")
  end
end
