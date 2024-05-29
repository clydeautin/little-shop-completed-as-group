require 'csv'

namespace :csv_load do
  desc "Load customers csv data task"

  task customers: :environment do
    customers_path = "./db/data/customers.csv"
    CSV.foreach(customers_path, headers: true) do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
  end

  desc "Load invoice items csv data task"
  task invoice_items: :environment do
    invoice_items_path = "./db/data/invoice_items.csv"
    CSV.foreach(invoice_items_path, headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
  end

  desc "Load invoices csv data task"
  task invoices: :environment do
    invoices_path = "./db/data/invoices.csv"
    CSV.foreach(invoices_path, headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
  end

  desc "Load items csv data task"
  task items: :environment do
    items_path = "./db/data/items.csv"
    CSV.foreach(items_path, headers: true) do |row|
      Item.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
  end

  desc "Load merchants csv data task"
  task merchants: :environment do
    merchants_path = "./db/data/merchants.csv"
    CSV.foreach(merchants_path, headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
  end

  desc "Load transaction csv data task"
  task transactions: :environment do
    transactions_path = "./db/data/transactions.csv"
    CSV.foreach(transactions_path, headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
  end

  desc "Load customers, invoice items, invoices, items, merchants, and transactions csv data task"
  task all: [
  'csv_load:customers',
  'csv_load:merchants',
  'csv_load:items',
  'csv_load:invoices',
  'csv_load:invoice_items',
  'csv_load:transactions'
]

  # task all: :environment do
  #   paths = {
  #     customers: './db/data/customers.csv',
  #     invoice_items: './db/data/invoice_items.csv',
  #     invoices: './db/data/invoices.csv',
  #     items: './db/data/items.csv',
  #     merchants: './db/data/merchants.csv',
  #     transactions: './db/data/transactions.csv'
  #   }
  #   CSV.foreach(paths[:customers], headers: true) do |row|
  #     Customer.create!(row.to_hash)
  #   end
  #   CSV.foreach(paths[:invoice_items], headers: true) do |row|
  #     InvoiceItems.create!(row.to_hash)
  #   end
  #   CSV.foreach(paths[:invoices], headers: true) do |row|
  #     Invoice.create!(row.to_hash)
  #   end
  #   CSV.foreach(paths[:items], headers: true) do |row|
  #     Item.create!(row.to_hash)
  #   end
  #   CSV.foreach(paths[:merchants], headers: true) do |row|
  #     Merchant.create!(row.to_hash)
  #   end
  #   CSV.foreach(paths[:transactions], headers: true) do |row|
  #     Transaction.create!(row.to_hash)
  #   end

  #   # probably shouldnt reset ALL tables pk
  #   ActiveRecord::Base.connection.tables.each do |t|
  #     ActiveRecord::Base.connection.reset_pk_sequence!(t)
  #   end
  # end
end