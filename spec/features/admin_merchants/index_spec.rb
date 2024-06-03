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

    #for false positives
    @merchant2 = create(:merchant, status: 1)
    @item8 = create(:item, merchant: @merchant2, unit_price: 7000)
  
    @invoice8 = create(:invoice, customer: @customer7, status: 1)
    @invoice_item8 = create(:invoice_item, invoice: @invoice8, item: @item8, quantity: 1, unit_price: @item8.unit_price, status: 1)
    8.times { create(:transaction, invoice: @invoice8, result: 'success') }
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
      if @merchant.status == "enabled"
        expect(page).to have_content(@merchant.name)
        expect(page).to have_button("Disable")
      elsif @merchant.status == "disabled"
        expect(page).to have_content(@merchant.name)
        expect(page).to have_button("Enable")
      end
    end

    within "#merchant-#{@merchant2.id}" do
      if @merchant2.status == "enabled"
        expect(page).to have_content(@merchant2.name)
        expect(page).to have_button("Disable")
      elsif @merchant2.status == "disabled"
        expect(page).to have_content(@merchant2.name)
        expect(page).to have_button("Enable")
      end
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

  xit "has a link to create new merchant" do
    visit admin_merchants_path

    expect(page).to have_link("Create New Merchant")

    click_link("Create New Merchant")

    expect(current_path).to eq(new_merchant_item_path(merchant_id: @merchant))
  end
end