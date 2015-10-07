class CreateDonations < ActiveRecord::Migration
  def change
    create_join_table :campaigns, :users, table_name: :donations
  end
end
