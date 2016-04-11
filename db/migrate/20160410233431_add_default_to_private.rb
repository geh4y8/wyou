class AddDefaultToPrivate < ActiveRecord::Migration
  def change
    change_column_default(:campaigns, :private, false)
  end
end
