require "rails_helper"

RSpec.describe "the merchant dashboard page" do
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
    # @customer8 = FactoryBot.create(:customer)
    # @customer9 = FactoryBot.create(:customer)
    # @customer10 = FactoryBot.create(:customer)

    #budget merchant
    @item1 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 110)
    @item2 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 120)
    @item3 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 130)
    @item4 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 210)
    @item5 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 220)
    @item6 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 230)
    @item7 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 310)
    # @item8 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 320)
    # @item9 = FactoryBot.create(:item, merchant: @merchant1, unit_price: 330)
    
    #mid tier merchant
    @item8 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1100)
    @item9 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1200)
    @item10 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1300)
    @item11 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2100)
    @item12 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2200)
    @item13 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2300)
    @item14 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 3100)
    # @item17 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 3200)
    # @item18 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 3300)

    @item15 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1100)
    @item16 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1200)
    @item17 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1300)
    @item18 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2100)
    @item19 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2200)
    @item20 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2300)
    @item21 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 3100)
    # @item26 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 3200)
    # @item27 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 3300)

    @item22 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1100)
    @item23 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1200)
    @item24 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 1300)
    @item25 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2100)
    @item26 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2200)
    @item27 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 2300)
    @item28 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 3100)
    # @item35 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 3200)
    # @item36 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 3300)

    #high tier items
    @item29 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 11000)
    @item30 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 12000)
    @item31 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 13000)
    @item32 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 21000)
    @item33 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 22000)
    @item34 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 23000)
    @item35 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 31000)
    # @item44 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 32000)
    # @item45 = FactoryBot.create(:item, merchant: @merchant3, unit_price: 33000)

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
    @invoice14 = FactoryBot.create(:invoice, customer: @customer4, status: 0)
    @invoice15 = FactoryBot.create(:invoice, customer: @customer4, status: 0)
    @invoice16 = FactoryBot.create(:invoice, customer: @customer4, status: 0)

    @invoice17 = FactoryBot.create(:invoice, customer: @customer5, status: 1)
    @invoice18 = FactoryBot.create(:invoice, customer: @customer5, status: 1)
    # @invoice19 = FactoryBot.create(:invoice, customer: @customer5, status: 1)
    
    @invoices_tier2 = [
    @invoice19 = FactoryBot.create(:invoice, customer: @customer6, status: 1),
    # @invoice21 = FactoryBot.create(:invoice, customer: @customer6, status: 2)
    # @invoice22 = FactoryBot.create(:invoice, customer: @customer6, status: 2)

    @invoice20 = FactoryBot.create(:invoice, customer: @customer7, status: 0)
    # @invoice24 = FactoryBot.create(:invoice, customer: @customer7, status: 1)
    # @invoice25 = FactoryBot.create(:invoice, customer: @customer7, status: 2)

    # @invoice26 = FactoryBot.create(:invoice, customer: @customer8, status: 0)
    # @invoice27 = FactoryBot.create(:invoice, customer: @customer8, status: 1)
    # @invoice28 = FactoryBot.create(:invoice, customer: @customer8, status: 1)

    # @invoice29 = FactoryBot.create(:invoice, customer: @customer9, status: 0)
    # @invoice30 = FactoryBot.create(:invoice, customer: @customer9, status: 0)
    # @invoice31 = FactoryBot.create(:invoice, customer: @customer9, status: 0)

    # @invoice32 = FactoryBot.create(:invoice, customer: @customer10, status: 2)
    # @invoice33 = FactoryBot.create(:invoice, customer: @customer10, status: 2)
    # @invoice34 = FactoryBot.create(:invoice, customer: @customer10, status: 2)
    ]

    # @transaction1 = FactoryBot.create(:transaction, invoice: @invoice1, result: "success")
    # @transaction2 = FactoryBot.create(:transaction, invoice: @invoice1)
    # @transaction3 = FactoryBot.create(:transaction, invoice: @invoice1)

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
  
  end
  describe "As a merchant" do
    describe "when I visit merchant invoices index" do
      it "shows all the invoices that include at least one of my items" do
        visit merchant_invoices_path(@merchant1)

        @merchant1.invoices.each do |invoice|
          within "#invoice-#{invoice.id}" do
          expect(page).to have_content("Invoice ID: #{invoice.id}")
          expect(page).to have_content("Customer ID: #{invoice.customer_id}")
          expect(page).to have_content("Invoice status: #{invoice.status}")
          expect(page).to have_link("#{invoice.id}", 
                                    href: "/merchants/#{@merchant1.id}/invoices/#{invoice.id}")
          end
        end
      end
    end
  end
end