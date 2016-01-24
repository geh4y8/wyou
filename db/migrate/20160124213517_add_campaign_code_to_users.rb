class AddCampaignCodeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :campaign_code, :string
  end
end
