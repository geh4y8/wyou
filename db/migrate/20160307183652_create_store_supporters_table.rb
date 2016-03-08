class CreateStoreSupportersTable < ActiveRecord::Migration
  def change
    create_table :store_supporters do |t|
      t.integer :user_id
      t.integer :campaign_id
    end
  end
end
