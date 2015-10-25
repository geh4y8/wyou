class CreateCampaignsProducts < ActiveRecord::Migration
  def change
    create_table :campaigns_products do |t|
      t.belongs_to :campaign, index: true
      t.belongs_to :product, index: true
    end
  end
end
