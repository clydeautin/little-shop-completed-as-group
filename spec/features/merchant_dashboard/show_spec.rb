require "rails_helper"

RSpec.describe "the merchant dashboard page" do
  before :each do
    @merchant1 = Merchant.create!(name: "Nordstrom")

  end
  it "displays the name of the merchant" do
    visit "/merchants/#{@merchant1.id}/dashboard"

    expect(page).to have_content("Nordstrom")
  end

  it "has links for merchant items index and merchant invoices index" do
    visit "/merchants/#{@merchant1.id}/dashboard"

    expect(page).to have_link("Items Index")
    expect(page).to have_link("Invoices Index")
  end

  # 3. Merchant Dashboard Statistics - Favorite Customers
  # As a merchant,
  # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
  # Then I see the names of the top 5 customers
  # who have conducted the largest number of successful transactions with my merchant
  # And next to each customer name I see the number of successful transactions they have
  # conducted with my merchant
  it "can see top 5 customer names each with successful transaction count with merchant" do
    visit "/merchants/#{@merchant1.id}/dashboard"

    within "favorite_customers" do
      expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name}: #{customer1.largest_successful_transaction(@merchant1.id)} purchases")
      expect(page).to have_content("#{@customer2.first_name} #{@customer2.last_name}: #{customer2.largest_successful_transaction(@merchant1.id)} purchases")
      expect(page).to have_content("#{@customer3.first_name} #{@customer3.last_name}: #{customer3.largest_successful_transaction(@merchant1.id)} purchases")
      expect(page).to have_content("#{@customer4.first_name} #{@customer4.last_name}: #{customer4.largest_successful_transaction(@merchant1.id)} purchases")
      expect(page).to have_content("#{@customer5.first_name} #{@customer5.last_name}: #{customer5.largest_successful_transaction(@merchant1.id)} purchases")
    end
  end

  # 4. Merchant Dashboard Items Ready to Ship
  # As a merchant
  # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
  # Then I see a section for "Items Ready to Ship"
  # In that section I see a list of the names of all of my items that
  # have been ordered and have not yet been shipped,
  # And next to each Item I see the id of the invoice that ordered my item
  # And each invoice id is a link to my merchant's invoice show page
  xit "can see list of item names each with its invoice id as a link to merchant invoice show page" do
    visit "/merchants/#{@merchant1.id}/dashboard"

    within "items_ready_to_ship" do
      expect(page).to have_content("#{@item1.name} - Invoice ##{@invoice1.id} - #{@invoice1.create_date}")
      expect(page).to have_content("#{@item2.name} - Invoice ##{@invoice1.id} - #{@invoice1.create_date}")
      expect(page).to have_content("#{@item3.name} - Invoice ##{@invoice2.id} - #{@invoice2.create_date}")
      expect(page).to have_content("#{@item4.name} - Invoice ##{@invoice3.id} - #{@invoice3.create_date}")
      
      expect(page).to have_link("##{@invoice1.id}", href: "/merchants/#{@invoice1.id}/invoice")
      expect(page).to have_link("##{@invoice2.id}", href: "/merchants/#{@invoice2.id}/invoice")
      expect(page).to have_link("##{@invoice3.id}", href: "/merchants/#{@invoice3.id}/invoice")
    end

    
  end

  # 5. Merchant Dashboard Invoices sorted by least recent
  # As a merchant
  # When I visit my merchant dashboard (/merchants/:merchant_id/dashboard)
  # In the section for "Items Ready to Ship",
  # Next to each Item name I see the date that the invoice was created
  # And I see the date formatted like "Monday, July 18, 2019"
  # And I see that the list is ordered from oldest to newest
  xit "can see date on invoice creation next to each item ordered from oldest to newest" do
    visit "/merchants/#{@merchant1.id}/dashboard"

    within "items_ready_to_ship" do
      # expect(page).to have_content("- #{@invoice1.create_date}")
      expect(page).to have_content("- #{@invoice1.create_date}")
      expect(page).to have_content("- #{@invoice2.create_date}")
      expect(page).to have_content("- #{@invoice3.create_date}")
    end
  end
end