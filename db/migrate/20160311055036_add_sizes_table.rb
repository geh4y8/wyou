class AddSizesTable < ActiveRecord::Migration
  def change
    create_table :sizes do |t|
      t.belongs_to :product
      t.string :size
    end
  end
end
