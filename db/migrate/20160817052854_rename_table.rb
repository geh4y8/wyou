class RenameTable < ActiveRecord::Migration
  def change
    rename_table :user_feedback, :user_feedbacks
  end
end
