class AddAdditionalNotesColumnToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :additional_notes, :text
  end
end
