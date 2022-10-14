class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true, length: { in: 3..20 }
end
