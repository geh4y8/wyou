class AddTimestampsToCampaigns < ActiveRecord::Migration
  def change
    add_column(:campaigns, :created_at, :datetime)
    add_column(:campaigns, :updated_at, :datetime)
  end
end
