require "rails_helper"

RSpec.describe InvoiceItem do
  describe "validations" do
    it {should validate_presence_of :quantity}
    it {should validate_presence_of :unit_price}
    it {should validate_presence_of :status}
  end

  describe "relationships" do
    it {should belong_to :invoice}
    it {should belong_to :item}
    it {should have_many(:transactions).through(:invoice)}
  end

  describe "methods" do
    before :each do
      @merchant_a = FactoryBot.create(:merchant)
      @merchant_b = FactoryBot.create(:merchant)
      @item_a = FactoryBot.create(:item, merchant: @merchant_a, unit_price: 2200) # 30% off = 
      @item_b = FactoryBot.create(:item, merchant: @merchant_a, unit_price: 2300)
      @item_c = FactoryBot.create(:item, merchant: @merchant_a, unit_price: 3100)
      
      @item_e = FactoryBot.create(:item, merchant: @merchant_b, unit_price: 5299)

      @customer1 = FactoryBot.create(:customer)

      @invoice_a = FactoryBot.create(:invoice, customer: @customer1, status: 1)

      @invoice_item_a = FactoryBot.create(:invoice_item, invoice: @invoice_a, item: @item_a, quantity: 11, unit_price: @item_a.unit_price) # $242 // $169.4
      @invoice_item_b = FactoryBot.create(:invoice_item, invoice: @invoice_a, item: @item_b, quantity: 6, unit_price: @item_b.unit_price) # $138 // $110.4
      @invoice_item_c = FactoryBot.create(:invoice_item, invoice: @invoice_a, item: @item_c, quantity: 2, unit_price: @item_c.unit_price) # $62 Tot= $442 // T = $341.8
      @invoice_item_d = FactoryBot.create(:invoice_item, invoice: @invoice_a, item: @item_e, quantity: 11, unit_price: @item_e.unit_price)

      @loyalty = Discount.create!(name: "Loyalty", percentage: 10, threshold: 3, merchant_id: @merchant_a.id)
      @silver_l = Discount.create!(name: "Silver Loyalty", percentage: 20, threshold: 5, merchant_id: @merchant_a.id)
      @gold_l = Discount.create!(name: "Gold Loyalty", percentage: 30, threshold: 10, merchant_id: @merchant_a.id)

      @summer_disc = Discount.create!(name: "Summer Discount", percentage: 17, threshold: 14, merchant_id: @merchant_b.id)
    end

      describe "#best_discount" do

        it 'returns the best discount applicable' do
          expect(@invoice_item_a.best_discount).to eq(@gold_l)
          expect(@invoice_item_b.best_discount).to eq(@silver_l)
        end

        it 'returns nil if no discounts are applicable' do
          expect(@invoice_item_c.best_discount).to be_nil
        end
      end

      describe '#discounted_price' do

        it 'returns the best discounted price if a discount is applicable' do
          expect(@invoice_item_a.discounted_price).to eq(1540.0)
        end

        it 'returns the original price if no discounts are applicable' do
          expect(@invoice_item_c.discounted_price).to eq(3100)
        end
      end
  end
end