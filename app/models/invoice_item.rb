class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :bulk_discounts, through: :item

  enum status: {"pending" => 0, "packaged" => 1, "shipped" => 2}

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status

  def best_bulk_discount
    bulk_discounts.where('quantity <= ?', quantity)
    .order('bulk_discounts.discount').last
  end
end
