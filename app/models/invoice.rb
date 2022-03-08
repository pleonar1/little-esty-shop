class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: {"cancelled" => 0, "in progress" => 1, "completed" => 2}

  validates_presence_of :status

  def total_invoice_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def self.not_completed
    where(:invoices => {status: 1}).order(created_at: :asc)
  end

  def total_revenue_for_merchant(merchant)
    invoice_items.select("invoice_items.id, (invoice_items.unit_price * invoice_items.quantity) AS revenue")
                 .group("invoice_items.id")
                 .joins(:item)
                 .where("items.merchant_id = ?", merchant)
                 .sum(&:revenue)
  end
end
