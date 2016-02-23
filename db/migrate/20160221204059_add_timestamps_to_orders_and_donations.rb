class AddTimestampsToOrdersAndDonations < ActiveRecord::Migration
  def change_table
      add_column(:donations, :created_at, :datetime)
      add_column(:donations, :updated_at, :datetime)
      add_column(:orders, :created_at, :datetime)
      add_column(:orders, :updated_at, :datetime)
    end
end
