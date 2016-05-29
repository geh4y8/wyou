class AddFavoriteBrandToUsers < ActiveRecord::Migration
  def change
    add_column :users, :favorite_brand, :string
  end
end
