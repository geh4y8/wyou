class AddColumnsForPatientRegistrationUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :is_patient, :boolean
    add_column :users, :managed_account, :boolean
    add_column :users, :managed_name, :string
    add_column :users, :managed_email, :string
    add_column :users, :preferred_name, :string
    add_column :users, :zip_code, :string
    add_column :users, :gender, :string
    add_column :users, :symptoms, :text
    add_column :users, :diagnosis, :text
    add_column :users, :treatment_plan, :text
    add_column :users, :treatment_schedule, :text
    add_column :users, :item_needed_by, :date
    add_column :users, :normal_size, :string
    add_column :users, :plus_size, :boolean
    add_column :users, :petite_size, :boolean
    add_column :users, :other_notes, :text
  end
end
