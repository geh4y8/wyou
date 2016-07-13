class InviteMailer < ApplicationMailer
  default from: 'notifications@wyou.co'
  def invite_contributor_email(invite)
    @invite = invite
    @campaign = @invite.campaign
    @url = "wyou.co/users/sign_up?campaign_code=#{@campaign.campaign_code}"
    mail(
      to: @invite.contributor_email,
      subject: "[w/you] You have been invited to contribute!"
    )
  end
end
