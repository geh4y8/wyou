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
    @url = "wyou.co/campaigns/#{@campaign.id}"
    mail(
      to: @campaign.patient_email,
      subject: "[w/you] Donation Received!")
  end
end
