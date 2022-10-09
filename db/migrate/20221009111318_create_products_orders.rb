class CreateProductsOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :products_orders do |t|
      t.integer :category_id
      t.integer :product_id
      t.timestamps
    end
  end
end
