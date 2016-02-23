class AddCampaignInvitesTable < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :contributor_name
      t.string :contributor_email
      t.text :contributor_message

      t.timestamps
    end
  end
end
