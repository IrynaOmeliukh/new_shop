class Order < ApplicationRecord
  has_many :products_orders
  has_many :products, through: :products_orders
  enum :order_status, {
    'New order': 'new_order',
    'Packaging': 'packaging',
    'Deliver in process': 'deliver_in_process',
    'Done': 'done'
    }, default: 'new_order'
end
