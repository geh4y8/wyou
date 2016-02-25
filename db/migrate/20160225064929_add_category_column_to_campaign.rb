class AddCategoryColumnToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :category_id, :integer
  end
end
