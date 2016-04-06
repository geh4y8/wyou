class DonationMailerPreview
  def confirm_donation_email
    DonationMailer.confirm_donation_email campaign, user, donation_amount
  end


  def new_donation_email
    DonationMailer.new_donation_email campaign, user, donation_amount
  end
end
