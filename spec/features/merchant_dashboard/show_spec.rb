require "rails_helper"

RSpec.describe "the merchant dashboard page" do
  before(:each) do
    @merchant = create(:merchant)

    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
    @customer6 = create(:customer)
    @customer7 = create(:customer)

    @item1 = create(:item, merchant: @merchant, unit_price: 1000)
    @item2 = create(:item, merchant: @merchant, unit_price: 2000)
    @item3 = create(:item, merchant: @merchant, unit_price: 3000)
    @item4 = create(:item, merchant: @merchant, unit_price: 4000)
    @item5 = create(:item, merchant: @merchant, unit_price: 5000)
    @item6 = create(:item, merchant: @merchant, unit_price: 6000)
    @item7 = create(:item, merchant: @merchant, unit_price: 7000)

    @invoice1 = create(:invoice, customer: @customer1, status: 1)
    @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 1, unit_price: @item1.unit_price)
    6.times { create(:transaction, invoice: @invoice1, result: 'success') }

    @invoice2 = create(:invoice, customer: @customer2, status: 1)
    @invoice_item2 = create(:invoice_item, invoice: @invoice2, item: @item2, quantity: 1, unit_price: @item2.unit_price)
    2.times { create(:transaction, invoice: @invoice2, result: 'success') }

    @invoice3 = create(:invoice, customer: @customer3, status: 1)
    @invoice_item3 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 1, unit_price: @item3.unit_price)
    4.times { create(:transaction, invoice: @invoice3, result: 'success') }

    @invoice4 = create(:invoice, customer: @customer4, status: 1)
    @invoice_item4 = create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 1, unit_price: @item4.unit_price)
    5.times { create(:transaction, invoice: @invoice4, result: 'success') }

    @invoice5 = create(:invoice, customer: @customer5, status: 1)
    @invoice_item5 = create(:invoice_item, invoice: @invoice5, item: @item1, quantity: 1, unit_price: @item1.unit_price)
    3.times { create(:transaction, invoice: @invoice5, result: 'success') }

    @invoice6 = create(:invoice, customer: @customer6, status: 0)
    @invoice_item6 = create(:invoice_item, invoice: @invoice6, item: @item2, quantity: 1, unit_price: @item2.unit_price)
    create(:transaction, invoice: @invoice6, result: 'success')

    @invoice7 = create(:invoice, customer: @customer7, status: 0)
    @invoice_item7 = create(:invoice_item, invoice: @invoice7, item: @item3, quantity: 1, unit_price: @item3.unit_price)
    create(:transaction, invoice: @invoice7, result: 'success')
  end

  it "displays the name of the merchant" do
    visit "/merchants/#{@merchant.id}/dashboard"

    expect(page).to have_content(@merchant.name)
  end

  it "has links for merchant items index and merchant invoices index" do
    visit "/merchants/#{@merchant.id}/dashboard"

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
  it "has top 5 customer names each with successful transaction count with merchant" do
    visit "/merchants/#{@merchant.id}/dashboard"

    within "#favorite_customers" do
      expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name} - #{@customer1.successful_transactions_with_merchant(@merchant)} purchases")
      expect(page).to have_content("#{@customer2.first_name} #{@customer2.last_name} - #{@customer2.successful_transactions_with_merchant(@merchant)} purchases")
      expect(page).to have_content("#{@customer3.first_name} #{@customer3.last_name} - #{@customer3.successful_transactions_with_merchant(@merchant)} purchases")
      expect(page).to have_content("#{@customer4.first_name} #{@customer4.last_name} - #{@customer4.successful_transactions_with_merchant(@merchant)} purchases")
      expect(page).to have_content("#{@customer5.first_name} #{@customer5.last_name} - #{@customer5.successful_transactions_with_merchant(@merchant)} purchases")
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
  xit "has list of all items name each with its invoice id as a link to merchant invoice show page" do
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