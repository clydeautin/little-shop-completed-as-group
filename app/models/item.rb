class Item < ApplicationRecord
  enum status: {
    enabled: 0,
    disabled: 1
  }
  
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoice_items
end