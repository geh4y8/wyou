class CreateCampaignsTable < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :name
      t.integer :fund_amount
      t.integer :fund_goal
    end
  end
end
