require "rails_helper"

RSpec.describe "the merchant item index page" do
  before(:each) do
    @merchant = create(:merchant)

    @customer1 = create(:customer)
    @customer2 = create(:customer)
    @customer3 = create(:customer)
    @customer4 = create(:customer)
    @customer5 = create(:customer)
    @customer6 = create(:customer)
    @customer7 = create(:customer)

    @item1 = create(:item, merchant: @merchant, unit_price: 1000, status: 0)
    @item2 = create(:item, merchant: @merchant, unit_price: 2000, status: 0)
    @item3 = create(:item, merchant: @merchant, unit_price: 3000, status: 0)
    @item4 = create(:item, merchant: @merchant, unit_price: 4000, status: 0)
    @item5 = create(:item, merchant: @merchant, unit_price: 5000, status: 1)
    @item6 = create(:item, merchant: @merchant, unit_price: 6000, status: 1)
    @item7 = create(:item, merchant: @merchant, unit_price: 7000, status: 1)

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
    @invoice_item6 = create(:invoice_item, invoice: @invoice6, item: @item2, quantity: 1, unit_price: @item2.unit_price, status:01)
    create(:transaction, invoice: @invoice6, result: 'success')

    @invoice7 = create(:invoice, customer: @customer7, status: 0)
    @invoice_item7 = create(:invoice_item, invoice: @invoice7, item: @item3, quantity: 1, unit_price: @item3.unit_price, status:01)
    create(:transaction, invoice: @invoice7, result: 'success')

    #for false positives
    @merchant2 = create(:merchant)
    @item8 = create(:item, merchant: @merchant2, unit_price: 7000)
  
    @invoice8 = create(:invoice, customer: @customer7, status: 1)
    @invoice_item8 = create(:invoice_item, invoice: @invoice8, item: @item8, quantity: 1, unit_price: @item8.unit_price, status: 1)
    8.times { create(:transaction, invoice: @invoice8, result: 'success') }
  end

  # us6
  it "I see a list of the names of all of my items and I do not see items for any other merchant" do
    visit "/merchants/#{@merchant.id}/items"

    within "#merchant_items" do
      @merchant.items.each do |item|
        expect(page).to have_content(item.name)
      end
    end

    within "#merchant_items" do
      @merchant2.items.each do |item|
        expect(page).to_not have_content(item.name)
      end
    end
  end

  #us9
  it "I can disable or enable an item with a button next to the item" do
    visit "/merchants/#{@merchant.id}/items"

    @merchant.items.each do |item|
      within "#item-#{item.id}" do
        if item.status == "enabled"
          expect(page).to have_content(item.name)
          expect(page).to have_button("Disable")
        elsif item.status == "disabled"
          expect(page).to have_content(item.name)
          expect(page).to have_button("Enable")
        end
      end
    end

    within "#item-#{@item1.id}" do
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")

      click_button "Disable"

      expect(page).to have_current_path("/merchants/#{@merchant.id}/items")
      expect(page).to have_button("Enable")
      expect(page).to_not have_button("Disable")
    end
  end
  
  #US10
  it "groups items by enabled and disabled" do
    visit "/merchants/#{@merchant.id}/items"

    expect("Enabled Items").to appear_before("Disabled Items")

    within "#enabled_items" do
      expect(page).to have_button("Disable")
      expect(page).to_not have_button("Enable")

      expect(page).to have_content(@item1.name)
      expect(page).to_not have_content(@item5.name)
    end

    within "#disabled_items" do
      expect(page).to have_button("Enable")
      expect(page).to_not have_button("Disable")

      expect(page).to have_content(@item5.name)
      expect(page).to_not have_content(@item1.name)
    end
  end

  #US11

  it "has a link to create new item" do
    visit merchant_items_path(@merchant)

    expect(page).to have_link("Create New Item")

    click_link("Create New Item")

    expect(current_path).to eq(new_merchant_item_path(merchant_id: @merchant))
  end

  it "can create a list of top 5 items" do
    @invoice9 = create(:invoice, customer: @customer7, status: 0)
    @invoice_item9 = create(:invoice_item, invoice: @invoice9, item: @item5, quantity: 1, unit_price: @item5.unit_price, status: 0)
    create(:transaction, invoice: @invoice9, result: 'success')

    visit merchant_items_path(@merchant)

    within "#top_five" do
      expect(@item4.name).to appear_before(@item3.name)
      expect(@item3.name).to appear_before(@item1.name)
      expect(@item1.name).to appear_before(@item2.name)
      expect(@item2.name).to appear_before(@item5.name)

      expect(page).to have_link("#{@item4.name}")

      expect(@item4.name).to appear_before("Total Revenue Generated: $200.00")
      expect("Total Revenue Generated: $200.00").to appear_before(@item3.name)
      expect(@item3.name).to appear_before("Total Revenue Generated: $150.00")
    end
  end

end