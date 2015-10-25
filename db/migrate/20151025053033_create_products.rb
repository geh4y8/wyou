class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :retail_price, :precision=> 8, :scale => 2
    end
  end
end
