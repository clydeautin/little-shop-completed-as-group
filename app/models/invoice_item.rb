class InvoiceItem < ApplicationRecord
  enum status: {
    pending: 0,
    packaged: 1,
    shipped: 2
  }

  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true
  
  belongs_to :invoice
  belongs_to :item
  has_many :transactions, through: :invoice

  def best_discount
    item.merchant.discounts
        .where('threshold <= ?', quantity)
        .order(percentage: :desc)
        .first
  end
end