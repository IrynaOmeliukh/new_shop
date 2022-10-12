class Product < ApplicationRecord
  enum :status, {
    'Out of stock': 'out_of_stock',
    'In stock': 'in_stock',
    'Running low': 'running_low'
    }, default: 'in_stock'
  belongs_to :category
  has_many :products_orders
  has_many :orders, through: :products_orders

end
