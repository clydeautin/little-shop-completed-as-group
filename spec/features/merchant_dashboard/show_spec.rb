require "rails_helper"

RSpec.describe "the merchant dashboard page" do
  before(:each) do
    @merchant = create(:merchant)
    #budget merchant
    @merchant1 = FactoryBot.create(:merchant)
    #mid-tier merchant
    @merchant2 = FactoryBot.create(:merchant)
    #high-tier merchant
    @merchant3 = FactoryBot.create(:merchant)
    @merchant4 = FactoryBot.create(:merchant)
    @merchant5 = FactoryBot.create(:merchant)
    @merchant6 = FactoryBot.create(:merchant)

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
    @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 1, unit_price: @item1.unit_price, status: 1)
    6.times { create(:transaction, invoice: @invoice1, result: 'success') }

    @invoice2 = create(:invoice, customer: @customer2, status: 1)
    @invoice_item2 = create(:invoice_item, invoice: @invoice2, item: @item2, quantity: 1, unit_price: @item2.unit_price, status: 1)
    2.times { create(:transaction, invoice: @invoice2, result: 'success') }

    @invoice3 = create(:invoice, customer: @customer3, status: 1)
    @invoice_item3 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 1, unit_price: @item3.unit_price, status: 1)
    4.times { create(:transaction, invoice: @invoice3, result: 'success') }

    @invoice4 = create(:invoice, customer: @customer4, status: 1)
    @invoice_item4 = create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 1, unit_price: @item4.unit_price, status: 1)
    5.times { create(:transaction, invoice: @invoice4, result: 'success') }

    @invoice5 = create(:invoice, customer: @customer5, status: 1)
    @invoice_item5 = create(:invoice_item, invoice: @invoice5, item: @item1, quantity: 1, unit_price: @item1.unit_price, status: 1)
    3.times { create(:transaction, invoice: @invoice5, result: 'success') }

    @invoice6 = create(:invoice, customer: @customer6, status: 0)
    @invoice_item6 = create(:invoice_item, invoice: @invoice6, item: @item2, quantity: 1, unit_price: @item2.unit_price, status: 0)
    create(:transaction, invoice: @invoice6, result: 'success')

    @invoice7 = create(:invoice, customer: @customer7, status: 0)
    @invoice_item7 = create(:invoice_item, invoice: @invoice7, item: @item3, quantity: 1, unit_price: @item3.unit_price, status: 0)
    create(:transaction, invoice: @invoice7, result: 'success')

    @merchant2 = create(:merchant)
    @item8 = create(:item, merchant: @merchant2, unit_price: 7000)
  
    @invoice8 = create(:invoice, customer: @customer7, status: 1)
    @invoice_item8 = create(:invoice_item, invoice: @invoice8, item: @item8, quantity: 1, unit_price: @item8.unit_price, status: 1)
    8.times { create(:transaction, invoice: @invoice8, result: 'success') }
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

  it "has top 5 customer names each with successful transaction count with merchant" do
    visit "/merchants/#{@merchant.id}/dashboard"
    @top_five_customers = @merchant.top_five_customers

    within "#favorite_customers" do
      @top_five_customers.each do |customer|
        expect(page).to have_content("#{customer.first_name} #{customer.last_name} - #{customer.purchases} purchases")
      end
    end
  end

  it "has list of all items name each with its invoice id as a link to merchant invoice show page" do
    visit "/merchants/#{@merchant.id}/dashboard"

    within "#items_ready_to_ship" do
      expect(page).to have_content("#{@item1.name} - Invoice ##{@invoice1.id} - #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("#{@item2.name} - Invoice ##{@invoice2.id} - #{@invoice2.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("#{@item3.name} - Invoice ##{@invoice3.id} - #{@invoice3.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("#{@item4.name} - Invoice ##{@invoice4.id} - #{@invoice4.created_at.strftime("%A, %B %d, %Y")}")

      expect(page).to_not have_content(@item6.name)
      expect(page).to_not have_content(@item7.name)
      expect(page).to_not have_content("Invoice ##{@invoice6.id}")
      expect(page).to_not have_content("Invoice ##{@invoice7.id}")
      
      expect(page).to have_link("#{@invoice1.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice1.id}")
      expect(page).to have_link("#{@invoice2.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice2.id}")
      expect(page).to have_link("#{@invoice3.id}", href: "/merchants/#{@merchant.id}/invoices/#{@invoice3.id}")
    end
  end

  it "can see date on invoice creation next to each item ordered from oldest to newest" do
    @invoice1.created_at = "2022-01-22 00:00:00"
    @invoice1.save
    @invoice2.created_at = "2022-02-22 00:00:00"
    @invoice2.save
    @invoice3.created_at = "2021-03-22 00:00:00"
    @invoice3.save
    @invoice4.created_at = "2022-04-22 00:00:00"
    @invoice4.save
    @invoice5.created_at = "2021-05-22 00:00:00"
    @invoice5.save
    @invoice6.created_at = "2022-01-21 00:00:00"
    @invoice6.save
    @invoice7.created_at = "2022-01-23 00:00:00"
    @invoice7.save
    visit "/merchants/#{@merchant.id}/dashboard"

    within "#items_ready_to_ship" do
      expect("Invoice ##{@invoice3.id}").to appear_before("Invoice ##{@invoice1.id}", only_text: true)
      expect("Invoice ##{@invoice5.id}").to appear_before("Invoice ##{@invoice1.id}", only_text: true)
      expect("Invoice ##{@invoice1.id}").to appear_before("Invoice ##{@invoice4.id}", only_text: true)
      expect("Invoice ##{@invoice2.id}").to appear_before("Invoice ##{@invoice4.id}", only_text: true)
    end
  end

  #   As a merchant
  # When I visit my merchant dashboard
  # [] Then I see a link to view all my discounts
  # When I click this link
  # Then I am taken to my bulk discounts index page
  # [] Where I see all of my bulk discounts including their
  # [] percentage discount and quantity thresholds
  # [] And each bulk discount listed includes a link to its show page

  it 'has a link to bulk discount index' do

    visit "/merchants/#{@merchant1.id}/dashboard"

    expect(page).to have_link("View All my Discounts", href: "/merchants/#{@merchant.id}/discounts")
    click_link("View All my Discounts")

    expect(page).to have_current_path("/merchants/#{@merchant1.id}/discounts")

    @merchant1.discounts.each do |discount|
      within "#discount-#{discount.id}" do
      expect(page).to have_content("Promo name: #{discount.name}")
      expect(page).to have_content("Discount percentage: #{discount.percentage}")
      expect(page).to have_content("Quantity threshold: #{discount.threshold}")
      expect(page).to have_link("/merchants/#{discount.merchant.id}/discounts/#{discount.id}")
      end
    end
  end
end