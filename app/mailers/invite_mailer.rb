class InviteMailer < ApplicationMailer

  def invite_contributor_email(invite)
    @invite = invite
    @campaign = @invite.campaign
    @url = "wyoutestdeploy1.herokuapp.com/users/sign_up"
    mail(
      from: @campaign.owner_email,
      to: @invite.contributor_email,
      subject: "[w/you] You have been invited to contribute!"
    )
  end
end
