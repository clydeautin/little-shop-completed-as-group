require "rails_helper"

RSpec.describe "the admin merchants index" do
  before(:each) do
    @merchant = create(:merchant, status: 0)

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

    @merchant2 = create(:merchant, status: 1)
    @item8 = create(:item, merchant: @merchant2, unit_price: 7000)
  
    @invoice8 = create(:invoice, customer: @customer7, status: 1)
    @invoice_item8 = create(:invoice_item, invoice: @invoice8, item: @item8, quantity: 1, unit_price: @item8.unit_price, status: 1)
    8.times { create(:transaction, invoice: @invoice8, result: 'success') }

    @merchant3 = create(:merchant, status: 1)
    @item9 = create(:item, merchant: @merchant3, unit_price: 1000)
  
    @invoice9 = create(:invoice, customer: @customer7, status: 1)
    @invoice_item9 = create(:invoice_item, invoice: @invoice9, item: @item9, quantity: 1, unit_price: @item9.unit_price, status: 1)
    1.times { create(:transaction, invoice: @invoice9, result: 'success') }

    @merchant4 = create(:merchant, status: 1)
    @item10 = create(:item, merchant: @merchant4, unit_price: 1000)
  
    @invoice10 = create(:invoice, customer: @customer7, status: 1)
    @invoice_item10 = create(:invoice_item, invoice: @invoice10, item: @item10, quantity: 1, unit_price: @item10.unit_price, status: 1)
    2.times { create(:transaction, invoice: @invoice10, result: 'success') }

    @merchant5 = create(:merchant, status: 1)
    @item11 = create(:item, merchant: @merchant5, unit_price: 1000)
  
    @invoice11 = create(:invoice, customer: @customer7, status: 1)
    @invoice_item11 = create(:invoice_item, invoice: @invoice11, item: @item11, quantity: 1, unit_price: @item11.unit_price, status: 1)
    3.times { create(:transaction, invoice: @invoice11, result: 'success') }
  end

  it "displays names of all merchants" do
    visit admin_merchants_path

    expect(page).to have_content(@merchant.name)
    expect(page).to have_content(@merchant2.name)
  end

  it "should have links for every name" do
    visit admin_merchants_path

    expect(page).to have_link(@merchant.name)
    expect(page).to have_link(@merchant2.name)
  end

  it "I can disable or enable an item with a button next to the item" do
    visit admin_merchants_path

    within "#merchant-#{@merchant.id}" do
      expect(page).to have_content(@merchant.name)
      expect(page).to have_button("Disable")
    end

    within "#merchant-#{@merchant2.id}" do
      expect(page).to have_content(@merchant2.name)
      expect(page).to have_button("Enable")
    end

    within "#merchant-#{@merchant.id}" do
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")

      click_button "Disable"

      expect(page).to have_current_path(admin_merchants_path)
      expect(page).to have_button("Enable")
      expect(page).to_not have_button("Disable")
    end
  end

  it "groups merchants by enabled and disabled" do
    visit admin_merchants_path

    expect("Enabled Merchants").to appear_before("Disabled Merchants")

    within "#enabled_merchants" do
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")

      expect(page).to have_content(@merchant.name)
      expect(page).to_not have_content(@merchant2.name)
    end

    within "#disabled_merchants" do
      expect(page).to have_button("Enable")
      expect(page).to_not have_button("Disable")

      expect(page).to have_content(@merchant2.name)
      expect(page).to_not have_content(@merchant.name)
    end
  end

  it "has a link to create new merchant" do
    visit admin_merchants_path

    expect(page).to have_link("Create New Merchant")

    click_link("Create New Merchant")

    expect(current_path).to eq(new_admin_merchant_path)
  end

  it "displays top five merchants in order" do
    visit admin_merchants_path
    within "#top_five" do
      expect(@merchant2.name).to appear_before(@merchant.name)
      expect(@merchant.name).to appear_before(@merchant5.name)
      expect(@merchant5.name).to appear_before(@merchant4.name)
      expect(@merchant4.name).to appear_before(@merchant3.name)

      expect(page).to have_link("#{@merchant2.name}")

      expect(@merchant2.name).to appear_before("Total Revenue Generated: $560.00")
      expect("Total Revenue Generated: $560.00").to appear_before(@merchant.name)
      expect(@merchant.name).to appear_before("Total Revenue Generated: $500.00")
    end
  end

  it "displays biggest day for most popular items" do
    visit admin_merchants_path

    within "#top_five" do
      expect(page).to have_content("Top selling date for #{@merchant2.name} was #{@invoice8.created_at.strftime("%A, %B %d, %Y")}")
    end
  end

end