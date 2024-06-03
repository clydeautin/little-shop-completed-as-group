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

  def best_day
    invoice_items.joins(:transactions)
      .where("transactions.result = 'success'")
      .select('invoices.created_at, sum(invoice_items.quantity)')
      .group('invoices.created_at')
      .order('sum(invoice_items.quantity) desc')
      .limit(1)
      .pluck('invoices.created_at')[0]
      .strftime("%A, %B %d, %Y")
  end
end