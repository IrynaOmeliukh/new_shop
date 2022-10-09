class RemoveCategoryIdFromProductsOrders < ActiveRecord::Migration[7.0]
  def change
    remove_column :products_orders, :category_id, :integer
  end
end
