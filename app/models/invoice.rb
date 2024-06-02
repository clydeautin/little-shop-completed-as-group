class Invoice < ApplicationRecord
  enum status: {
    "in progress": 0,
    completed: 1,
    cancelled: 2
  }

  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions
end