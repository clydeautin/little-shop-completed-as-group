require "rails_helper"

RSpec.describe "the discount show page" do
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

    @july4 = Discount.create!(name: "Independence Day", percentage: 10, threshold: 3, merchant_id: @merchant1.id)
    @labor_day = Discount.create!(name: "Labor Day", percentage: 20, threshold: 5, merchant_id: @merchant1.id)
    @xmas = Discount.create!(name: "Christmas", percentage: 30, threshold: 10, merchant_id: @merchant1.id)

    @xmas = Discount.create!(name: "Joyeux nouvelle annee", percentage: 17, threshold: 14, merchant_id: @merchant2.id)

  end

  # 4: Merchant Bulk Discount Show

  # As a merchant
  # [x] When I visit my bulk discount show page
  # [x] Then I see the bulk discount's quantity threshold and percentage discount

  it "allows me to view a bulk discount" do
    visit "/merchants/#{@merchant1.id}/discounts/#{@july4.id}"

    # save_and_open_page
    expect(page).to have_content("Discount name: #{@july4.name}")
    expect(page).to have_content("Discount percentage: #{@july4.percentage}")
    expect(page).to have_content("Discount threshold: #{@july4.threshold}")
  end

  #   5: Merchant Bulk Discount Edit

  # As a merchant
  # [x] When I visit my bulk discount show page
  # [x] Then I see a link to edit the bulk discount
  # [x] When I click this link
  # [x] Then I am taken to a new page with a form to edit the discount
  # [x] And I see that the discounts current attributes are pre-poluated in the form
  # [x] When I change any/all of the information and click submit
  # [x] Then I am redirected to the bulk discount's show page
  # [x] And I see that the discount's attributes have been updated

  it "allows me to edit a bulk discount" do
    visit "/merchants/#{@merchant1.id}/discounts/#{@july4.id}"
    
    expect(page).to have_link("Edit Discount")
    click_link "Edit Discount"
    # save_and_open_page
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@july4.id}/edit")

    expect(find_field('Name').value).to eq(@july4.name)
    expect(find_field('Percentage').value).to eq(@july4.percentage.to_s)
    expect(find_field('Threshold').value).to eq(@july4.threshold.to_s)

    fill_in 'Name', with: 'American Freedom Day'
    click_button 'Submit'

    expect(current_path).to eq(merchant_discount_path(@merchant1, @july4))
    expect(page).to have_content("Discount name: American Freedom Day")
  end

  it "wont save a bulk discount if I leave a field blank" do
    visit "/merchants/#{@merchant1.id}/discounts/#{@july4.id}"
    
    expect(page).to have_link("Edit Discount")
    click_link "Edit Discount"
    # save_and_open_page
    expect(current_path).to eq("/merchants/#{@merchant1.id}/discounts/#{@july4.id}/edit")

    expect(find_field('Name').value).to eq(@july4.name)
    expect(find_field('Percentage').value).to eq(@july4.percentage.to_s)
    expect(find_field('Threshold').value).to eq(@july4.threshold.to_s)

    fill_in 'Name', with: ''
    click_button 'Submit'
    expect(page).to have_content("Failed to update discount")

  end
end