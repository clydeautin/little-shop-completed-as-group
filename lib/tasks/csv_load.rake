
require 'csv'

namespace :csv_load do
  # def disable_foreign_keys
  #   ActiveRecord::Base.connection.execute("SET session_replication_role = 'replica';")
  # end
  
  # def enable_foreign_keys
  #   ActiveRecord::Base.connection.execute("SET session_replication_role = 'origin';")
  # end
  # These methods work to bypass foreign key restraints
  # I wasn't sure how else to handle the foreign key restraint while deleting records with children. 
  # This seems like an unsafe way to do this but I'm not sure

  desc "Load customers csv data task"
  task customers: :environment do
    # disable_foreign_keys
    Customer.destroy_all
    customers_path = "./db/data/customers.csv"
    CSV.foreach(customers_path, headers: true) do |row|
      Customer.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('customers')
    # enable_foreign_keys
    puts "Successfully loaded customers"
  end

  desc "Load invoice items csv data task"
  task invoice_items: :environment do
    # disable_foreign_keys
    InvoiceItem.destroy_all
    invoice_items_path = "./db/data/invoice_items.csv"
    CSV.foreach(invoice_items_path, headers: true) do |row|
      InvoiceItem.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoice_items')
    enable_foreign_keys
    puts "Successfully loaded invoice_items"
  end

  desc "Load invoices csv data task"
  task invoices: :environment do
    # disable_foreign_keys
    Invoice.destroy_all
    invoices_path = "./db/data/invoices.csv"
    CSV.foreach(invoices_path, headers: true) do |row|
      Invoice.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('invoices')
    # enable_foreign_keys
    puts "Successfully loaded invoices"
  end

  desc "Load items csv data task"
  task items: :environment do
    # disable_foreign_keys
    Item.destroy_all
    items_path = "./db/data/items.csv"
    CSV.foreach(items_path, headers: true) do |row|
      row_hash = row.to_hash
      row_hash["status"] = 'enabled'

      Item.create!(row_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('items')
    # enable_foreign_keys
    puts "Successfully loaded items"
  end

  desc "Load merchants csv data task"
  task merchants: :environment do
    # disable_foreign_keys
    Merchant.destroy_all
    merchants_path = "./db/data/merchants.csv"
    CSV.foreach(merchants_path, headers: true) do |row|
      Merchant.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('merchants')
    # enable_foreign_keys
    puts "Successfully loaded merchants"
  end

  desc "Load transaction csv data task"
  task transactions: :environment do
    disable_foreign_keys
    Transaction.destroy_all
    transactions_path = "./db/data/transactions.csv"
    CSV.foreach(transactions_path, headers: true) do |row|
      Transaction.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!('transactions')
    # enable_foreign_keys
    puts "Successfully loaded transactions"
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
end
