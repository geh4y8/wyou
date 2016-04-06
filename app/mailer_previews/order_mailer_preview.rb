class OrderMailerPreview
  def order_confirmation_email
    OrderMailer.order_confirmation_email order
  end


  def order_shipment_confirmation_email
    OrderMailer.order_shipment_confirmation_email order
  end
end
