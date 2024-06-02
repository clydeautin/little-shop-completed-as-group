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
    @invoice_item6 = create(:invoice_item, invoice: @invoice6, item: @item2, quantity: 1, unit_price: @item2.unit_price, status:01)
    create(:transaction, invoice: @invoice6, result: 'success')

    @invoice7 = create(:invoice, customer: @customer7, status: 0)
    @invoice_item7 = create(:invoice_item, invoice: @invoice7, item: @item3, quantity: 1, unit_price: @item3.unit_price, status:01)
    create(:transaction, invoice: @invoice7, result: 'success')

    @merchant2 = create(:merchant)
    @item8 = create(:item, merchant: @merchant2, unit_price: 7000)
  
    @invoice8 = create(:invoice, customer: @customer7, status: 1)
    @invoice_item8 = create(:invoice_item, invoice: @invoice8, item: @item8, quantity: 1, unit_price: @item8.unit_price, status: 1)
    8.times { create(:transaction, invoice: @invoice8, result: 'success') }
  end

  # us8.part2
  it "I see a form filled in with the existing item attribute information
    When I update the information in the form and I click ‘submit’
    Then I am redirected back to the item show page where I see the updated information
    And I see a flash message stating that the information has been successfully updated." do
      
    visit "/merchants/#{@merchant.id}/items/#{@item1.id}"
      
    within "#items_attr" do
      expect(page).to have_content(@item1.name)
      expect(page).to have_content("Description: #{@item1.description}")
      expect(page).to have_content("Current Price: #{@item1.unit_price}")
    end

    click_on "Update Item"
    
    within "#update_attr" do
      fill_in "name", with: "I HAVE" 
      fill_in "description", with: "Power level OVER" 
      fill_in "price", with: 9000
    end

    click_button "Update"

    expect(page).to have_current_path("/merchants/#{@merchant.id}/items/#{@item1.id}")
    
    within "#items_attr" do
      expect(page).to have_content("I HAVE")
      expect(page).to have_content("Description: Power level OVER")
      expect(page).to have_content("Current Price: 9000")
# need to test for sad path/edge cases
    end
  end
end