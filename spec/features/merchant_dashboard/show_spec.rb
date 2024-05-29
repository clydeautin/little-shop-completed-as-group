require "rails_helper"

RSpec.describe "the merchant dashboard page" do
  it "displays the name of the merchant" do
    @merchant1 = Merchant.create!(name: "Nordstrom")

    visit "/merchants/#{@merchant1.id}/dashboard"

    expect(page).to have_content("Nordstrom")
  end

  it "has links for merchant items index and merchant invoices index" do
    @merchant1 = Merchant.create!(name: "Nordstrom")

    visit "/merchants/#{@merchant1.id}/dashboard"

    expect(page).to have_link("Items Index")
    expect(page).to have_link("Invoices Index")
  end
end