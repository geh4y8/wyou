class RemoveColumnFromUsersAddToCampaign < ActiveRecord::Migration
  def change
    remove_column :users, :donation_alerts
    add_column :campaigns, :donation_alerts, :boolean
  end
end
