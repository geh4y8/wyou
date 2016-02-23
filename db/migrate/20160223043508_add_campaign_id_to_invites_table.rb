class AddCampaignIdToInvitesTable < ActiveRecord::Migration
  def change
    add_column :invites, :campaign_id, :integer
  end
end
