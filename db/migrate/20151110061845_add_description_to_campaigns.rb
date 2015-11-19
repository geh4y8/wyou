class AddDescriptionToCampaigns < ActiveRecord::Migration
  def change
    add_column :campaigns, :provide_description, :text
  end
end
