class OrderMailer < ApplicationMailer
  default from: 'notifications@wyou.co'

  def order_confirmation_email(order)
    @order = order
    @campaign = @order.campaign
    @url = "wyoutestdeploy2.herokuapp.com/#{@campaign.id}/orders/#{@order.id}"
    mail(
      to: "#{@campaign.patient_email}",
      subject: "[w/you] Order Confirmation")
  end

  def order_shipment_confirmation_email(order)
    @order = order
    @campaign = @order.campaign

    mail(
      to: "#{@campaign.patient_email}",
      subject: "[w/you] Your order has shipped!"
    )
  end
end
