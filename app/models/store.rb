class Store < ActiveRecord::Base
  belongs_to :campaign
  has_many :products

  def self.products_in_cart(cart)
    total = 0
    cart.each do |product, amount|
      total += amount
    end
    return total
  end
end
