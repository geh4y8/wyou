class CreateSupporters < ActiveRecord::Migration
  def change
    create_table :supporters do |t|
      t.integer :campaign_id
      t.integer :user_id
    end
  end
end
