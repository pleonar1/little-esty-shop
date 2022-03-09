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

  def total_revenue_for_merchant(merchant_id)
    invoice_items.select("invoice_items.id, (invoice_items.unit_price * invoice_items.quantity) AS revenue")
                 .group("invoice_items.id")
                 .joins(:item)
                 .where("items.merchant_id = ?", merchant_id)
                 .sum(&:revenue)
  end

  def total_discount_for_merchant(merchant_id)
    invoice_items.joins(:bulk_discounts)
    .where("invoice_items.quantity >= bulk_discounts.quantity AND bulk_discounts.merchant_id = ?", merchant_id)
    .select("invoice_items.id, MAX((invoice_items.unit_price * invoice_items.quantity * bulk_discounts.discount)) AS discounted_revenue")
    .group("invoice_items.id")
    .sum(&:discounted_revenue)
  end

  def revenue_after_discount(merchant_id)
    ((total_revenue_for_merchant(merchant_id) - (total_discount_for_merchant(merchant_id)).to_f/100))
  end

  def total_discounted_revenue
    invoice_items.joins(:bulk_discounts)
                 .where("invoice_items.quantity >= bulk_discounts.quantity")
                 .select("invoice_items.id, MAX((invoice_items.unit_price * invoice_items.quantity * bulk_discounts.discount)) AS discounted_revenue")
                 .group("invoice_items.id")
                 .sum(&:discounted_revenue)
  end

  def final_price
    ((total_invoice_revenue) - (total_discounted_revenue).to_f/100)
  end
end
