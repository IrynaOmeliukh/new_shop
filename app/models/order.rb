class Order < ApplicationRecord
  enum :order_status, {
    'New order': 'new_order',
    'Packaging': 'packaging',
    'Deliver in process': 'deliver_in_process',
    'Done': 'done'
  }, default: 'new_order'

  belongs_to :user
  has_and_belongs_to_many :products

  validates :first_name, presence: true, length: { in: 2..10 }
  validates :last_name, presence: true, length: { in: 2..10 }
  validates :phone, presence: true, length: { in: 2..10 }
  validates :address, presence: true

end
