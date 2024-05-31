class Merchant < ApplicationRecord
  validates :name, presence: true
  
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items
  has_many :transactions, through: :items
  has_many :customers, through: :invoices
end