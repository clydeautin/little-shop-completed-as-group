class Discount < ApplicationRecord
  
  validates :name, presence: true
  validates :percentage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100  }
  validates :threshold, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :merchant

  def eligible_and_pending?
    eligible_invoice_items.where(status: InvoiceItem.statuses[:pending]).exists?
  end

  def eligible_invoice_items
    InvoiceItem.joins(item: { merchant: :discounts })
              .where('items.merchant_id = ?', merchant_id)
              .where('invoice_items.quantity >= ?', threshold)
              .where('discounts.id = ?', id)
  end
end