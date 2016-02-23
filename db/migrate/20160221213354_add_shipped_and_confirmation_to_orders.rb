class AddShippedAndConfirmationToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipped, :boolean
    add_column :orders, :shipping_confirmation, :string
  end
end
