require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  describe "relationships" do
    it { should belong_to(:invoice) }
    it { should belong_to(:item) }
    it { should have_many(:bulk_discounts).through(:item) }

  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:status) }
  end

  describe "instance methods" do
    it "can search and find the best bulk discount to apply" do
      merchant_1 = Merchant.create!(name: "Staples")

      item_1 = merchant_1.items.create!(name: "stapler", description: "Staples papers together", unit_price: 13)

      customer_1 = Customer.create!(first_name: "Person 1", last_name: "Mcperson 1")

      invoice_1 = customer_1.invoices.create!(status: "completed")
      invoice_2 = customer_1.invoices.create!(status: "completed")

      invoice_item_1 = InvoiceItem.create!(invoice_id: invoice_1.id, item_id: item_1.id, quantity: 100, unit_price: 100, status: "shipped")
      invoice_item_2 = InvoiceItem.create!(invoice_id: invoice_2.id, item_id: item_1.id, quantity: 1, unit_price: 100, status: "shipped")

      bulk_discount1 = merchant_1.bulk_discounts.create!(discount: 20, quantity: 10)
      bulk_discount2 = merchant_1.bulk_discounts.create!(discount: 30, quantity: 100)

      expect(invoice_item_1.best_bulk_discount).to eq(bulk_discount2)
      expect(invoice_item_2.best_bulk_discount).to eq(nil)
    end
  end
end
