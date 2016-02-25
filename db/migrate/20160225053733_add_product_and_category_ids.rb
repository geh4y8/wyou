class AddProductAndCategoryIds < ActiveRecord::Migration
  def change
    add_column :categories_products, :category_id, :integer
    add_column :categories_products, :product_id, :integer
  end
end
