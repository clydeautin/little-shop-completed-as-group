# lib/tasks/csv_load.rake
namespace :csv do
  desc "Load customer data from a CSV file"
  task load_customers: :environment do
    require 'csv'

    file_path = 'db/data/customers.csv'

    CSV.foreach(file_path, headers: true) do |row|
      Customer.create!(
        id: row['id'],
        first_name: row['first_name'],
        last_name: row['last_name'],
        created_at: row['created_at'],
        updated_at: row['updated_at'],
      )
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(t)
    puts "Customer data loaded successfully!"

    
  end
end
