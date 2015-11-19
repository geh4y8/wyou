class AddImagesToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :image_id, :string
    add_column :campaigns, :campaign_description, :text
  end
end
