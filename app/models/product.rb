class Product < ApplicationRecord

  belongs_to :category, optional: true
  has_and_belongs_to_many :orders

  validates :name, presence: true, length: { in: 3..20 }
  validates :price, presence: true, numericality: true
end
