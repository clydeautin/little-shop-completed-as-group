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
    @invoice_item1 = create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 1, unit_price: @item1.unit_price, status: 1)
    6.times { create(:transaction, invoice: @invoice1, result: 'success') }

    @invoice2 = create(:invoice, customer: @customer2, status: 1)
    @invoice_item2 = create(:invoice_item, invoice: @invoice2, item: @item2, quantity: 1, unit_price: @item2.unit_price, status: 1)
    2.times { create(:transaction, invoice: @invoice2, result: 'success') }

    @invoice3 = create(:invoice, customer: @customer3, status: 1)
    @invoice_item3 = create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 1, unit_price: @item3.unit_price, status: 2)
    4.times { create(:transaction, invoice: @invoice3, result: 'success') }

    @invoice4 = create(:invoice, customer: @customer4, status: 1)
    @invoice_item4 = create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 1, unit_price: @item4.unit_price, status: 2)
    5.times { create(:transaction, invoice: @invoice4, result: 'success') }

    @invoice5 = create(:invoice, customer: @customer5, status: 1)
    @invoice_item5 = create(:invoice_item, invoice: @invoice5, item: @item1, quantity: 1, unit_price: @item1.unit_price, status: 2)
    3.times { create(:transaction, invoice: @invoice5, result: 'success') }

    @invoice6 = create(:invoice, customer: @customer6, status: 0)
    @invoice_item6 = create(:invoice_item, invoice: @invoice6, item: @item2, quantity: 1, unit_price: @item2.unit_price, status: 2)
    create(:transaction, invoice: @invoice6, result: 'success')

    @invoice7 = create(:invoice, customer: @customer7, status: 0)
    @invoice_item7 = create(:invoice_item, invoice: @invoice7, item: @item3, quantity: 1, unit_price: @item3.unit_price, status: 0)
    create(:transaction, invoice: @invoice7, result: 'success')

    #for false positives
    @merchant2 = create(:merchant)
    @item8 = create(:item, merchant: @merchant2, unit_price: 7000)
  
    @invoice8 = create(:invoice, customer: @customer7, status: 1)
    @invoice_item8 = create(:invoice_item, invoice: @invoice8, item: @item8, quantity: 1, unit_price: @item8.unit_price, status: 1)
    8.times { create(:transaction, invoice: @invoice8, result: 'success') }
  end

  #us19
  it "displays the admin dashboard" do
    visit "/admin"

    expect(page).to have_content("Admin Dashboard")
  end
  #us20
  it "has links for merchant items index and merchant invoices index" do
    visit "/admin"

    expect(page).to have_link("Admin Merchants Index")
    expect(page).to have_link("Admin Invoices Index")
  end

  #us21
  it "has top 5 of all customers names each with successful transaction count " do
    visit "/admin"

    within "#top_customers" do
      expect(page).to have_content("#{@customer1.first_name} #{@customer1.last_name} - #{@customer1.successful_transactions} purchases")
      expect(page).to have_content("#{@customer3.first_name} #{@customer3.last_name} - #{@customer3.successful_transactions} purchases")
      expect(page).to have_content("#{@customer4.first_name} #{@customer4.last_name} - #{@customer4.successful_transactions} purchases")
      expect(page).to have_content("#{@customer5.first_name} #{@customer5.last_name} - #{@customer5.successful_transactions} purchases")
      expect(page).to have_content("#{@customer7.first_name} #{@customer7.last_name} - #{@customer7.successful_transactions} purchases")
    end
  end

  #us22
  it "has all invoices id that have items that have not shipped, each id is a link to that invoice's admin show page" do
    visit "/admin"

    within "#incomplete_invoices" do
      expect(page).to have_content("Invoice ##{@invoice1.id} - #{@invoice1.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Invoice ##{@invoice2.id} - #{@invoice2.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Invoice ##{@invoice7.id} - #{@invoice7.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to have_content("Invoice ##{@invoice8.id} - #{@invoice8.created_at.strftime("%A, %B %d, %Y")}")

      expect(page).to_not have_content("Invoice ##{@invoice3.id} - #{@invoice3.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to_not have_content("Invoice ##{@invoice4.id} - #{@invoice4.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to_not have_content("Invoice ##{@invoice5.id} - #{@invoice5.created_at.strftime("%A, %B %d, %Y")}")
      expect(page).to_not have_content("Invoice ##{@invoice6.id} - #{@invoice6.created_at.strftime("%A, %B %d, %Y")}")

      expect(page).to have_link("#{@invoice1.id}", href: "/admin/invoices/#{@invoice1.id}")
      expect(page).to have_link("#{@invoice2.id}", href: "/admin/invoices/#{@invoice2.id}")
      expect(page).to have_link("#{@invoice7.id}", href: "/admin/invoices/#{@invoice7.id}")
      expect(page).to have_link("#{@invoice8.id}", href: "/admin/invoices/#{@invoice8.id}")
    end
  end
end