class CreateJoinTableProductsWishLists < ActiveRecord::Migration[7.0]
  def change
    create_join_table :products, :wish_lists do |t|
      # t.index [:product_id, :wish_list_id]
      # t.index [:wish_list_id, :product_id]
    end
  end
end
