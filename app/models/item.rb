class Item < ApplicationRecord
  enum status: {
    enabled: 0,
    disabled: 1
  }

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true



  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoice_items
end