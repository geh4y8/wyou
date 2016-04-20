class AddSpecialToDonationsTable < ActiveRecord::Migration
  def change
    add_column :donations, :special, :boolean
  end
end
