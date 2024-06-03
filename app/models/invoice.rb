class Invoice < ApplicationRecord
  enum status: {
    "in progress": 0,
    completed: 1,
    cancelled: 2
  }

  validates :status, presence: true

  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :transactions

  def self.incomplete
    joins(:invoice_items).where.not(invoice_items: {status: 'shipped'}).order(:created_at).distinct
  end
end