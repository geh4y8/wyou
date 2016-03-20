class CreateOrdersSizesTable < ActiveRecord::Migration
  def change
    create_table :orders_sizes do |t|
      t.belongs_to :order, index: true
      t.belongs_to :size, index: true
      t.belongs_to :product, index: true
    end
  end
end
