class Order < ApplicationRecord
  enum :order_status, {
    'New order': 'new_order',
    'Packaging': 'packaging',
    'Deliver in process': 'deliver_in_process',
    'Done': 'done'
  }, default: 'new_order'

  has_and_belongs_to_many :products
end
