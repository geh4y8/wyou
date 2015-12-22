class AddRelationshipsToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :campaign, index: true
  end
end
