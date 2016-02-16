class AddCampaignCodeToCampaignTable < ActiveRecord::Migration
  def change
    add_column :campaigns, :campaign_code, :string
  end
end
