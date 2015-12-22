class AddOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :shipping_name
      t.string :shipping_street_address
      t.string :shipping_city
      t.string :shipping_state
      t.string :shipping_zip
      t.timestamps
    end
  end
end
