# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'factory_bot_rails'
require 'faker'

# Clear existing data
InvoiceItem.destroy_all
Transaction.destroy_all
Invoice.destroy_all
Customer.destroy_all
Item.destroy_all
Merchant.destroy_all

# # Creates 10 merchants
# 10.times do
#   FactoryBot.create(:merchant)
# end

# # Create 20 customers
# 20.times do
#   FactoryBot.create(:customer)
# end

# # Create 5 items and associate with merchants
# Merchant.all.each do |merchant|
#   5.times do
#     FactoryBot.create(:item, merchant: merchant)
#   end
# end

# # Create 3 invoices and associate with customers
# Customer.all.each do |customer|
#   3.times do
#     FactoryBot.create(:invoice, customer: customer)
#   end
# end

# # Create 2 transactions and associate with invoices
# Invoice.all.each do |invoice|
#   2.times do
#     FactoryBot.create(:transaction, invoice: invoice)
#   end
# end

# # Create invoice items and associate with invoices and items with random quantity between 1 and 10
# Invoice.all.each do |invoice|
#   items = Item.all.sample(3) #samples 3 items from invoice
#   items.each do |item|
#     FactoryBot.create(:invoice_item, invoice: invoice, item: item, quantity: rand(1..10), unit_price: item.unit_price)
#   end
# end
@merchant = FactoryBot.create(:merchant)

@customer1 = FactoryBot.create(:customer)
@customer2 = FactoryBot.create(:customer)
@customer3 = FactoryBot.create(:customer)
@customer4 = FactoryBot.create(:customer)
@customer5 = FactoryBot.create(:customer)
@customer6 = FactoryBot.create(:customer)
@customer7 = FactoryBot.create(:customer)

@item1 = FactoryBot.create(:item, merchant: @merchant, unit_price: 1000)
@item2 = FactoryBot.create(:item, merchant: @merchant, unit_price: 2000)
@item3 = FactoryBot.create(:item, merchant: @merchant, unit_price: 3000)
@item4 = FactoryBot.create(:item, merchant: @merchant, unit_price: 4000)
@item5 = FactoryBot.create(:item, merchant: @merchant, unit_price: 5000)
@item6 = FactoryBot.create(:item, merchant: @merchant, unit_price: 6000)
@item7 = FactoryBot.create(:item, merchant: @merchant, unit_price: 7000)

@invoice1 = FactoryBot.create(:invoice, customer: @customer1, status: 1)
@invoice_item1 = FactoryBot.create(:invoice_item, invoice: @invoice1, item: @item1, quantity: 1, unit_price: @item1.unit_price, status: 1)
6.times { FactoryBot.create(:transaction, invoice: @invoice1, result: 'success') }

@invoice2 = FactoryBot.create(:invoice, customer: @customer2, status: 1)
@invoice_item2 = FactoryBot.create(:invoice_item, invoice: @invoice2, item: @item2, quantity: 1, unit_price: @item2.unit_price, status: 1)
2.times { FactoryBot.create(:transaction, invoice: @invoice2, result: 'success') }

@invoice3 = FactoryBot.create(:invoice, customer: @customer3, status: 1)
@invoice_item3 = FactoryBot.create(:invoice_item, invoice: @invoice3, item: @item3, quantity: 1, unit_price: @item3.unit_price, status: 1)
4.times { FactoryBot.create(:transaction, invoice: @invoice3, result: 'success') }

@invoice4 = FactoryBot.create(:invoice, customer: @customer4, status: 1)
@invoice_item4 = FactoryBot.create(:invoice_item, invoice: @invoice4, item: @item4, quantity: 1, unit_price: @item4.unit_price, status: 1)
5.times { FactoryBot.create(:transaction, invoice: @invoice4, result: 'success') }

@invoice5 = FactoryBot.create(:invoice, customer: @customer5, status: 1)
@invoice_item5 = FactoryBot.create(:invoice_item, invoice: @invoice5, item: @item1, quantity: 1, unit_price: @item1.unit_price, status: 1)
3.times { FactoryBot.create(:transaction, invoice: @invoice5, result: 'success') }

@invoice6 = FactoryBot.create(:invoice, customer: @customer6, status: 0)
@invoice_item6 = FactoryBot.create(:invoice_item, invoice: @invoice6, item: @item2, quantity: 1, unit_price: @item2.unit_price, status:01)
FactoryBot.create(:transaction, invoice: @invoice6, result: 'success')

@invoice7 = FactoryBot.create(:invoice, customer: @customer7, status: 0)
@invoice_item7 = FactoryBot.create(:invoice_item, invoice: @invoice7, item: @item3, quantity: 1, unit_price: @item3.unit_price, status:01)
FactoryBot.create(:transaction, invoice: @invoice7, result: 'success')

@merchant2 = FactoryBot.create(:merchant)
@item8 = FactoryBot.create(:item, merchant: @merchant2, unit_price: 7000)

@invoice8 = FactoryBot.create(:invoice, customer: @customer7, status: 1)
@invoice_item8 = FactoryBot.create(:invoice_item, invoice: @invoice8, item: @item8, quantity: 1, unit_price: @item8.unit_price, status: 1)
8.times { FactoryBot.create(:transaction, invoice: @invoice8, result: 'success') }
puts "Seeding complete!"
