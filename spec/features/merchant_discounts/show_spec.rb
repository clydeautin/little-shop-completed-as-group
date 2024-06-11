require "rails_helper"

RSpec.describe "the discount show page" do
  before(:each) do
    #budget merchant
    @merchant1 = FactoryBot.create(:merchant)
    #mid-tier merchant
    @merchant2 = FactoryBot.create(:merchant)
    #high-tier merchant
    @merchant3 = FactoryBot.create(:merchant)
    @merchant4 = FactoryBot.create(:merchant)
    @merchant5 = FactoryBot.create(:merchant)
    @merchant6 = FactoryBot.create(:merchant)


    @customer1 = FactoryBot.create(:customer)
    @customer2 = FactoryBot.create(:customer)
    @customer3 = FactoryBot.create(:customer)
    @customer4 = FactoryBot.create(:customer)
    @customer5 = FactoryBot.create(:customer)
    @customer6 = FactoryBot.create(:customer)
    @customer7 = FactoryBot.create(:customer)

    #budget merchant
    @item1 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 110)
    @item2 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 120)
    @item3 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 130)
    @item4 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 210)
    @item5 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 220)
    @item6 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 230)
    @item7 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 310)

    #mid tier merchant
    @item8 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1100)
    @item9 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1200)
    @item10 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1300)
    @item11 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2100)
    @item12 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2200)
    @item13 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2300)
    @item14 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 3100)

    @item15 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1100)
    @item16 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1200)
    @item17 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1300)
    @item18 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2100)
    @item19 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2200)
    @item20 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2300)
    @item21 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 3100)

    @item22 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1100)
    @item23 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1200)
    @item24 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1300)
    @item25 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2100)
    @item26 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2200)
    @item27 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2300)
    @item28 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 3100)

    @item29 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 11000)
    @item30 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 12000)
    @item31 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 13000)
    @item32 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 21000)
    @item33 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 22000)
    @item34 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 23000)
    @item35 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 31000)

    #invoices
    @invoices_tier1 = [
      @invoice1 = FactoryBot.create(:invoice, customer: @customer1, status: 0),
      @invoice2 = FactoryBot.create(:invoice, customer: @customer1, status: 1),
      @invoice3 = FactoryBot.create(:invoice, customer: @customer1, status: 1),
      @invoice4 = FactoryBot.create(:invoice, customer: @customer1, status: 1),
      @invoice5 = FactoryBot.create(:invoice, customer: @customer1, status: 1),

      @invoice6 = FactoryBot.create(:invoice, customer: @customer2, status: 0),
      @invoice7 = FactoryBot.create(:invoice, customer: @customer2, status: 1),
      @invoice8 = FactoryBot.create(:invoice, customer: @customer2, status: 1),
      @invoice9 = FactoryBot.create(:invoice, customer: @customer2, status: 1),

      @invoice10 = FactoryBot.create(:invoice, customer: @customer3, status: 0),
      @invoice11 = FactoryBot.create(:invoice, customer: @customer3, status: 0),
      @invoice12 = FactoryBot.create(:invoice, customer: @customer3, status: 1),
      @invoice13 = FactoryBot.create(:invoice, customer: @customer3, status: 1)
    ]
    @invoice14 = FactoryBot.create(:invoice, customer: @customer4, status: 1)
    @invoice15 = FactoryBot.create(:invoice, customer: @customer4, status: 1)
    @invoice16 = FactoryBot.create(:invoice, customer: @customer4, status: 2)

    @invoice17 = FactoryBot.create(:invoice, customer: @customer5, status: 1)
    @invoice18 = FactoryBot.create(:invoice, customer: @customer5, status: 1)
    
    @invoices_tier2 = [
    @invoice19 = FactoryBot.create(:invoice, customer: @customer6, status: 1),
    @invoice20 = FactoryBot.create(:invoice, customer: @customer7, status: 1)
    ]

    [@invoice1, @invoice2, @invoice3, @invoice4, @invoice5].each do |invoice|
      3.times do
        FactoryBot.create(:transaction, invoice: invoice, result: "success")
      end
    end
    
    [@invoice6, @invoice7, @invoice8, @invoice9].each do |invoice|
      3.times do
        FactoryBot.create(:transaction, invoice: invoice, result: "success")
      end
    end
    
    [@invoice10, @invoice11, @invoice12, @invoice13].each do |invoice|
      3.times do
        FactoryBot.create(:transaction, invoice: invoice, result: "success")
      end
    end

    FactoryBot.create(:transaction, invoice: @invoice15, result: "failed")
    FactoryBot.create(:transaction, invoice: @invoice16, result: "failed")
    FactoryBot.create(:transaction, invoice: @invoice17, result: "success")

    FactoryBot.create(:transaction, invoice: @invoice18, result: "success")
    FactoryBot.create(:transaction, invoice: @invoice19, result: "failed")
    FactoryBot.create(:transaction, invoice: @invoice20, result: "success")

    @invoices_tier2.each do |invoice|
      3.times do
        FactoryBot.create(:transaction, invoice: invoice, result: "success")
      end
    end

    @invoice_item1 = FactoryBot.create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 1, unit_price: @item1.unit_price)
    @invoice_item2 = FactoryBot.create(:invoice_item, invoice: @invoice1, item: @item2, quantity: 2, unit_price: @item2.unit_price)

    @invoice_item3 = FactoryBot.create(:invoice_item, invoice: @invoice2, item: @item3, quantity: 2, unit_price: @item3.unit_price)
    @invoice_item4 = FactoryBot.create(:invoice_item, invoice: @invoice2, item: @item4, quantity: 2, unit_price: @item4.unit_price)
    
    @invoice_item5 = FactoryBot.create(:invoice_item, invoice: @invoice3, item: @item5, quantity: 2, unit_price: @item5.unit_price)
    @invoice_item6 = FactoryBot.create(:invoice_item, invoice: @invoice3, item: @item6, quantity: 2, unit_price: @item6.unit_price)
    
    @invoice_item7 = FactoryBot.create(:invoice_item, invoice: @invoice4, item: @item7, quantity: 2, unit_price: @item7.unit_price)
    
    @invoice_item8 = FactoryBot.create(:invoice_item, invoice: @invoice5, item: @item8, quantity: 2, unit_price: @item8.unit_price)
    @invoice_item9 = FactoryBot.create(:invoice_item, invoice: @invoice5, item: @item9, quantity: 2, unit_price: @item9.unit_price)
    
    @invoice_item10 = FactoryBot.create(:invoice_item, invoice: @invoice6, item: @item10, quantity: 3, unit_price: @item10.unit_price)
    
    @invoice_item11 = FactoryBot.create(:invoice_item, invoice: @invoice7, item: @item11, quantity: 3, unit_price: @item11.unit_price)
    @invoice_item12 = FactoryBot.create(:invoice_item, invoice: @invoice7, item: @item12, quantity: 3, unit_price: @item12.unit_price)
    
    @invoice_item13 = FactoryBot.create(:invoice_item, invoice: @invoice8, item: @item13, quantity: 3, unit_price: @item13.unit_price)
    @invoice_item14 = FactoryBot.create(:invoice_item, invoice: @invoice8, item: @item14, quantity: 3, unit_price: @item14.unit_price)
    
    @invoice_item15 = FactoryBot.create(:invoice_item, invoice: @invoice9, item: @item15, quantity: 3, unit_price: @item15.unit_price)
    @invoice_item16 = FactoryBot.create(:invoice_item, invoice: @invoice10, item: @item16, quantity: 1, unit_price: @item16.unit_price)
    @invoice_item17 = FactoryBot.create(:invoice_item, invoice: @invoice11, item: @item17, quantity: 1, unit_price: @item17.unit_price)
    @invoice_item18 = FactoryBot.create(:invoice_item, invoice: @invoice12, item: @item18, quantity: 1, unit_price: @item18.unit_price)
    @invoice_item19 = FactoryBot.create(:invoice_item, invoice: @invoice13, item: @item19, quantity: 1, unit_price: @item19.unit_price)
    @invoice_item20 = FactoryBot.create(:invoice_item, invoice: @invoice14, item: @item20, quantity: 1, unit_price: @item20.unit_price)
    @invoice_item21 = FactoryBot.create(:invoice_item, invoice: @invoice15, item: @item21, quantity: 1, unit_price: @item21.unit_price)
    @invoice_item22 = FactoryBot.create(:invoice_item, invoice: @invoice16, item: @item22, quantity: 1, unit_price: @item22.unit_price)
    @invoice_item23 = FactoryBot.create(:invoice_item, invoice: @invoice17, item: @item23, quantity: 1, unit_price: @item23.unit_price)
    @invoice_item24 = FactoryBot.create(:invoice_item, invoice: @invoice18, item: @item24, quantity: 1, unit_price: @item24.unit_price)
    @invoice_item25 = FactoryBot.create(:invoice_item, invoice: @invoice19, item: @item25, quantity: 1, unit_price: @item25.unit_price)
    
    @invoice_item26 = FactoryBot.create(:invoice_item, invoice: @invoice1, item: @item11, quantity: 2, unit_price: @item11.unit_price)
    
    @merchant_a = FactoryBot.create(:merchant)
    @merchant_b = FactoryBot.create(:merchant)
    @item_a = FactoryBot.create(:item, merchant: @merchant_a, unit_price: 2200)
    @item_b = FactoryBot.create(:item, merchant: @merchant_a, unit_price: 2300)
    @item_c = FactoryBot.create(:item, merchant: @merchant_a, unit_price: 3100)
    

    @item_e = FactoryBot.create(:item, merchant: @merchant_b, unit_price: 5299)
    

    @invoice_a = FactoryBot.create(:invoice, customer: @customer1, status: 1)
    @invoice_b = FactoryBot.create(:invoice, customer: @customer1, status: 2)

    @invoice_item_a = FactoryBot.create(:invoice_item, invoice: @invoice_a, item: @item_a, quantity: 11, unit_price: @item_a.unit_price, status: 0) # $242 // $169.4 // d = 72.6
    @invoice_item_b = FactoryBot.create(:invoice_item, invoice: @invoice_a, item: @item_b, quantity: 6, unit_price: @item_b.unit_price) # $138 // $110.4 // d = 27.6
    @invoice_item_c = FactoryBot.create(:invoice_item, invoice: @invoice_a, item: @item_c, quantity: 2, unit_price: @item_c.unit_price) # $62 Tot= $442 //  // T = $341.8
    @invoice_item_d = FactoryBot.create(:invoice_item, invoice: @invoice_a, item: @item_e, quantity: 5, unit_price: @item_e.unit_price) #$52 Tot= $260 // $234 // d =26  // T = $234 //
                                                                                                                                        # Total rev no D = $702
                                                                                                                                        # rev after D = $575.8
                                                                                                                                        # Total Discount = $126.2
    @loyalty = Discount.create!(name: "Loyalty", percentage: 10, threshold: 3, merchant_id: @merchant_a.id)
    @silver_l = Discount.create!(name: "Silver Loyalty", percentage: 20, threshold: 5, merchant_id: @merchant_a.id)
    @gold_l = Discount.create!(name: "Gold Loyalty", percentage: 30, threshold: 10, merchant_id: @merchant_a.id)
    @plat_l = Discount.create!(name: "Platinum Loyalty", percentage: 35, threshold: 20, merchant_id: @merchant_a.id)

    @summer_disc = Discount.create!(name: "Summer Discount", percentage: 17, threshold: 14, merchant_id: @merchant_b.id)

  end
  # 4: Merchant Bulk Discount Show

  # As a merchant
  # [x] When I visit my bulk discount show page
  # [x] Then I see the bulk discount's quantity threshold and percentage discount

  it "allows me to view a bulk discount" do
    visit "/merchants/#{@merchant_a.id}/discounts/#{@gold_l.id}"

    expect(page).to have_content("Discount name: #{@gold_l.name}")
    expect(page).to have_content("Discount percentage: #{@gold_l.percentage}")
    expect(page).to have_content("Discount threshold: #{@gold_l.threshold}")
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
    visit "/merchants/#{@merchant_a.id}/discounts/#{@plat_l.id}"
    
    expect(page).to have_link("Edit Discount")
    click_link "Edit Discount"

    expect(current_path).to eq("/merchants/#{@merchant_a.id}/discounts/#{@plat_l.id}/edit")

    expect(find_field('Name').value).to eq(@plat_l.name)
    expect(find_field('Percentage').value).to eq(@plat_l.percentage.to_s)
    expect(find_field('Threshold').value).to eq(@plat_l.threshold.to_s)

    fill_in 'Name', with: 'American Freedom Day'
    click_button 'Submit'

    expect(current_path).to eq(merchant_discount_path(@merchant_a, @plat_l))
    expect(page).to have_content("Discount name: American Freedom Day")
  end

  it "wont save a bulk discount if I leave a field blank" do
    visit "/merchants/#{@merchant_a.id}/discounts/#{@gold_l.id}"

    expect(page).to have_link("Edit Discount")
    click_link "Edit Discount"

    expect(current_path).to eq("/merchants/#{@merchant_a.id}/discounts/#{@gold_l.id}/edit")

    expect(find_field('Name').value).to eq(@gold_l.name)
    expect(find_field('Percentage').value).to eq(@gold_l.percentage.to_s)
    expect(find_field('Threshold').value).to eq(@gold_l.threshold.to_s)

    fill_in 'Name', with: ''
    click_button 'Submit'
    expect(page).to have_content("Failed to update discount")
  end

  it "when an invoice is pending merchant can't edit a bulk discount that applies to any of their items on that invoice" do
    visit "/merchants/#{@merchant_a.id}/discounts/#{@gold_l.id}"
    click_link "Edit Discount"

    fill_in 'Name', with: 'American Freedom Day'
    click_button 'Submit'
    expect(page).to have_content("Failed to update discount")
  end
end