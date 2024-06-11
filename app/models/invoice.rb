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

  def total_revenue
    invoice_items.sum('unit_price * quantity')
  end

  def total_discount
    a = invoice_items.joins(item: :merchant)
                    .joins('LEFT JOIN discounts ON discounts.merchant_id = merchants.id AND invoice_items.quantity >= discounts.threshold')
                    .select("invoice_items.id, coalesce(max(invoice_items.unit_price * invoice_items.quantity * (discounts.percentage /100.00)), 0) as total_discount")
                    .group("invoice_items.id")
                    .sum(&:"total_discount")
    total_revenue - a
  end

  def total_revenue_for_merchant(merchant)
    invoice_items.joins(:item).where(items: { merchant_id: merchant.id }).sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def total_discounted_revenue_for_merchant(merchant)
    invoice_items.joins(:item).where(items: { merchant_id: merchant.id }).sum do |invoice_item|
      invoice_item.discounted_price * invoice_item.quantity
    end
  end
  
  def self.incomplete
    joins(:invoice_items).where.not(invoice_items: {status: 'shipped'}).order(:created_at).distinct
  end
end