require 'rails_helper'

RSpec.describe 'Merchant Bulk Discounts Edit page' do
  it "has a form to edit the bulk discount, form is prepopulated with its existing values. User edits and hits submit and is redirected to show page where edits can be seen" do
    merchant_1 = Merchant.create!(name: "Staples")
    bulk_d1 = merchant_1.bulk_discounts.create!(quantity: 5, discount: 10)
    visit "/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_d1.id}/edit"

    expect(page).to have_field("Percent Off:", with: 10)
    expect(page).to have_field("Quantity Needed:", with: 5)

    fill_in "Percent Off:", with: 11
    fill_in "Quantity Needed:", with: 8
    click_button "Submit"

    expect(current_path).to eq("/merchants/#{merchant_1.id}/bulk_discounts/#{bulk_d1.id}")
    expect(page).to have_content("Percent Off: 11%")
    expect(page).to have_content("Quantity Needed: 8")
    expect(page).to_not have_content("Percent Off: 10%")
    expect(page).to_not have_content("Quantity Needed: 5")
  end

end
