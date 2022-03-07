require 'rails_helper'

RSpec.describe 'Merchant Bulk Discount Index' do
  describe "when I visit the Merchant bulk discount index as a merchant," do
    it "I see all of my bulk discounts inclusing their attributes" do
      merchant_1 = Merchant.create!(name: "Staples")
      merchant_2 = Merchant.create!(name: "Office Depot")
      bulk_d1 = merchant_1.bulk_discounts.create!(quantity: 5, discount: 10)
      bulk_d2 = merchant_1.bulk_discounts.create!(quantity: 10, discount: 10)
      bulk_d3 = merchant_2.bulk_discounts.create!(quantity: 50, discount: 10)

      visit "/merchants/#{merchant_1.id}/bulk_discounts"

      within "div.bulk_discount_#{bulk_d1.id}" do
        expect(page).to have_content(bulk_d1.quantity)
        expect(page).to have_content(bulk_d1.discount)
      end

      within "div.bulk_discount_#{bulk_d2.id}" do
        expect(page).to have_content(bulk_d2.quantity)
        expect(page).to have_content(bulk_d2.discount)
      end
      expect(page).to_not have_content(bulk_d3.quantity)
    end

    it "each bulk discount listed has a link to its show page" do
      merchant_1 = Merchant.create!(name: "Staples")
      bulk_d1 = merchant_1.bulk_discounts.create!(quantity: 5, discount: 10)

      visit "/merchants/#{merchant_1.id}/bulk_discounts"

      within "div.bulk_discount_#{bulk_d1.id}" do
        click_link "Bulk Discount #{bulk_d1.id}"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_d1.id}")
      end
    end

    it "has a link to create a new bulk discount" do
      merchant_1 = Merchant.create!(name: "Staples")

      visit "/merchants/#{merchant_1.id}/bulk_discounts"

      click_link("Create New Bulk Discount")

      expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/new")
    end

    it "next to each bulk discount is a link to delete it.  If clicked it redirects to index with the bd no longer there" do
      merchant_1 = Merchant.create!(name: "Staples")
      bulk_d1 = merchant_1.bulk_discounts.create!(quantity: 5, discount: 11)
      bulk_d2 = merchant_1.bulk_discounts.create!(quantity: 10, discount: 10)

      visit "/merchants/#{merchant_1.id}/bulk_discounts"

      expect(page).to have_content(bulk_d1.quantity)
      expect(page).to have_content(bulk_d1.discount)

      within "div.bulk_discount_#{bulk_d1.id}" do
        expect(page).to have_button("Delete")
      end

      within "div.bulk_discount_#{bulk_d2.id}" do
        click_button "Delete"
        expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts")
      end

      expect(page).to_not have_content(bulk_d1.quantity)
      expect(page).to_not have_content(bulk_d1.discount)
    end
  end
end
