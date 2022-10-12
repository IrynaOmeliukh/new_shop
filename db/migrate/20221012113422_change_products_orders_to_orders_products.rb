class ChangeProductsOrdersToOrdersProducts < ActiveRecord::Migration[7.0]
  def change
    rename_table :products_orders, :orders_products
  end
end
