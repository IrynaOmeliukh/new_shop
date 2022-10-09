class AddOrderIdToProductsOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :products_orders, :order_id, :integer
  end
end
