class AddColumnsForFormNewCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :patient_name, :string
    add_column :campaigns, :patient_email, :string
    add_column :campaigns, :patient_phone, :string
    add_column :campaigns, :relationship, :string
    add_column :campaigns, :owner_name, :string
    add_column :campaigns, :self_purchase, :boolean
    add_column :campaigns, :owner_email, :string
    add_column :campaigns, :inform_patient_date, :date
  end
end
