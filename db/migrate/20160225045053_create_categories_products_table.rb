class CreateCategoriesProductsTable < ActiveRecord::Migration
  def change
    create_table :categories_products, id: false do |t|
    end
  end
end
