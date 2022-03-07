require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Create' do
  describe "When I visit the MBD Create page," do
    it "I see a form to add a new bulk discount, once validly filled and submitted, redirects to index with new discount displayed" do
      merchant_1 = Merchant.create!(name: "Staples")
      visit "/merchants/#{merchant_1.id}/bulk_discounts/new"

      fill_in "Percent Off:", with: 20
      fill_in "Quantity Needed:", with: 10
      click_button "Submit"

      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts")
      expect(page).to have_content(BulkDiscount.last.discount)
      expect(BulkDiscount.last.discount).to eq(20)
    end
  end
end
