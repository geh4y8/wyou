class AddColumnToCampaignsProducts < ActiveRecord::Migration
  def change
    add_column :campaigns_products, :like_count, :integer
  end
end
