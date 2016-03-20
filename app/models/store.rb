class Store < ActiveRecord::Base
  belongs_to :campaign
  has_many :products

  def self.products_in_cart(cart)
    total = 0
    if cart
      cart.each do |product, amount|
        if amount.is_a? Integer
          total += amount
        end
      end
    end
    return total
  end
end
