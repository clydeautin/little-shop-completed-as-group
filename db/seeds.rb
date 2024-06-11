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
Discount.destroy_all
Merchant.destroy_all


# Creates 10 merchants
10.times do
  FactoryBot.create(:merchant)
end

# Create 20 customers
20.times do
  FactoryBot.create(:customer)
end

merchant1 = FactoryBot.create(:merchant)
merchant2 = FactoryBot.create(:merchant)

# Create 5 items and associate with merchants
Merchant.all.each do |merchant|
  5.times do
    FactoryBot.create(:item, merchant: merchant)
  end
end

# Create 3 invoices and associate with customers
Customer.all.each do |customer|
  3.times do
    FactoryBot.create(:invoice, customer: customer)
  end
end

# Create 2 transactions and associate with invoices
Invoice.all.each do |invoice|
  2.times do
    FactoryBot.create(:transaction, invoice: invoice)
  end
end

# Create invoice items and associate with invoices and items with random quantity between 1 and 10
Invoice.all.each do |invoice|
  items = Item.all.sample(3) #samples 3 items from invoice
  items.each do |item|
    FactoryBot.create(:invoice_item, invoice: invoice, item: item, quantity: rand(1..10), unit_price: item.unit_price)
  end
end

july4 = Discount.create!(name: "Independence Day", percentage: 10, threshold: 3, merchant_id: merchant1.id)
labor_day = Discount.create!(name: "Labor Day", percentage: 20, threshold: 5, merchant_id: merchant1.id)
xmas = Discount.create!(name: "Christmas", percentage: 30, threshold: 10, merchant_id: merchant1.id)

xmas = Discount.create!(name: "Joyeux nouvelle annee", percentage: 17, threshold: 14, merchant_id: merchant2.id)


puts "Seeding complete!"
