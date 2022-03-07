require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Show' do
  describe "When I visit a merchants bulk discount index page" do
    it "has the attributes of the bulk discount listed" do
      merchant_1 = Merchant.create!(name: "Staples")
      bulk_d1 = merchant_1.bulk_discounts.create!(quantity: 5, discount: 10)

      visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_d1.id}"

      expect(page).to have_content(bulk_d1.quantity)
      expect(page).to have_content(bulk_d1.discount)
    end

    it "has a link to the edit page" do
      merchant_1 = Merchant.create!(name: "Staples")
      bulk_d1 = merchant_1.bulk_discounts.create!(quantity: 5, discount: 10)

      visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_d1.id}"

      click_link "Edit"
      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_d1.id}/edit")
    end
  end
end
