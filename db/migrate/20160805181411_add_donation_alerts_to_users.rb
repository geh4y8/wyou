class AddDonationAlertsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :donation_alerts, :boolean
  end
end
