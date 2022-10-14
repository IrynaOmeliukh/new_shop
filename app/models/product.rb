class Product < ApplicationRecord
  enum :status, {
    'Out of stock': 'out_of_stock',
    'In stock': 'in_stock',
    'Running low': 'running_low'
    }, default: 'in_stock'

  belongs_to :category
  has_and_belongs_to_many :orders

  validates :name, presence: true, length: { in: 3..20 }
  validates :price, presence: true, numericality: true
end
