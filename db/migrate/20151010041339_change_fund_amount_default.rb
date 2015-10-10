class ChangeFundAmountDefault < ActiveRecord::Migration
  def change
    change_column :campaigns, :fund_goal, :integer, :default => 0
    change_column :campaigns, :fund_amount, :integer, :default => 0
  end
end
