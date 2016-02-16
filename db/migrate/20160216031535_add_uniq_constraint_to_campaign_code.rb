class AddUniqConstraintToCampaignCode < ActiveRecord::Migration
  def change
    add_index :campaigns, :campaign_code, :unique => true
  end
end
