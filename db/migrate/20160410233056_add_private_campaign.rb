class AddPrivateCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :private, :boolean
  end
end
