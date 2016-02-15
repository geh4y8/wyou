class OrderMailer < ApplicationMailer
  default from: 'notifications@wyou.co'

  def order_confirmation_email(order)
    @order = order
    @campaign = @order.campaign
    @url = "wyoutest1.herokuapp.com/#{@campaign.id}/orders/#{@order.id}"
    mail(
      to: "#{@campaign.patient_email}",
      subject: "[w/you] Order Confirmation")
  end
end
