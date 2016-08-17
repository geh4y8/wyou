class AddReasonForLeavingToUsersTable < ActiveRecord::Migration
  def change
    create_table :user_feedback do |t|
      t.string :user_name
      t.string :patient_name
      t.integer :campaign_id
      t.string :reason_for_leaving

      t.timestamps
    end
  end
end
