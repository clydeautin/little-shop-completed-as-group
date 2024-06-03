require "rails_helper"

RSpec.describe Merchant do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  
  describe "relationships" do
    it {should have_many :items}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:items)}
    it {should have_many(:transactions).through(:items)}
    it {should have_many(:customers).through(:invoices)}
  end

  before :each do
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
    @invoice_item6 = create(:invoice_item, invoice: @invoice6, item: @item2, quantity: 1, unit_price: @item2.unit_price, status: 0)
    create(:transaction, invoice: @invoice6, result: 'success')

    @invoice7 = create(:invoice, customer: @customer7, status: 0)
    @invoice_item7 = create(:invoice_item, invoice: @invoice7, item: @item3, quantity: 1, unit_price: @item3.unit_price, status: 0)
    create(:transaction, invoice: @invoice7, result: 'success')

    # second setup for false positives
    @merchant2 = create(:merchant)
    @item8 = create(:item, merchant: @merchant2, unit_price: 7000)
  
    @invoice8 = create(:invoice, customer: @customer7, status: 1)
    @invoice_item8 = create(:invoice_item, invoice: @invoice8, item: @item8, quantity: 1, unit_price: @item8.unit_price, status: 1)
    8.times { create(:transaction, invoice: @invoice8, result: 'success') }
  end

  describe "instance methods" do
    describe "top_five_customers" do
      it "can return top 5 customers of merchant" do

      expect(@merchant.top_five_customers).to eq([@customer1, @customer4, @customer3, @customer5, @customer2])
      end
    end

    describe "items_ready_to_ship" do
      it "can return merchants items that are ready to ship" do

        @item9 = create(:item, merchant: @merchant, unit_price: 9000)
        @invoice9 = create(:invoice, customer: @customer7, status: 0)
        @invoice_item9 = create(:invoice_item, invoice: @invoice9, item: @item9, quantity: 1, unit_price: @item9.unit_price, status: 0)
        create(:transaction, invoice: @invoice9, result: 'success')

        expect(@merchant.items_ready_to_ship).to eq([@item1, @item2, @item3, @item4, @item1])
      end
    end

    describe "enabled/disabled items" do
      it "can create list of enabled items" do
        expect(@merchant.enabled_items).to eq([@item1, @item2, @item3, @item4])
      end

      it "can create list of all disabled items" do
        expect(@merchant.disabled_items).to eq([@item5, @item6, @item7])
      end
    end
  end

  describe "class methods" do
    describe "top_five_customers" do
      it "can return top 5 of all customers by successful transactions" do

        expect(Merchant.top_five_customers).to eq([@customer7, @customer1, @customer4, @customer3, @customer5])
        end
    end
  end
end