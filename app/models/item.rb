class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  enum status: {"Disabled" => 0, "Enabled" => 1}

  def best_day
    x = invoices.joins(:transactions, :invoice_items)
        .where(transactions:{result: 1})
        .select("invoices.*, SUM( invoice_items.unit_price * invoice_items.quantity)  AS totalrevenue")
        .group("invoices.id")
        binding.pry
        .order(totalrevenue: :desc)
        .first.created_at
  end

end
