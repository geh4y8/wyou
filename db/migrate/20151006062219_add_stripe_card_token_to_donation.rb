class AddStripeCardTokenToDonation < ActiveRecord::Migration
  def change
    add_column :donations, :card_token, :string
  end
end
