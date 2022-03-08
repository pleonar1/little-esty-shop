class BulkDiscount < ApplicationRecord
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoices, through: :items

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :discount, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 100 }
end
