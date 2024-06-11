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

  def total_discount #total discount for all items from every merchant on a customer's invoice
    a = invoice_items.joins(item: :discounts)
                    .where('invoice_items.quantity >= discounts.threshold')
                    .select("invoice_items.id, coalesce(max(invoice_items.unit_price * invoice_items.quantity * (discounts.percentage /100.00)), 0) as total_discount")
                    .group("invoice_items.id")
                    .sum(&:"total_discount")
    total_revenue - a
  end

  def total_revenue_for_merchant(merchant)
    invoice_items.joins(:item).where(items: { merchant_id: merchant.id }).sum('invoice_items.unit_price * invoice_items.quantity')
  end

  def total_discounted_revenue_for_merchant(merchant)
    a = invoice_items.joins(item: :discounts)
                      .where(items: { merchant_id: merchant.id })
                      .where('invoice_items.quantity >= discounts.threshold')
                      .select("invoice_items.id, coalesce(max(invoice_items.unit_price * invoice_items.quantity * (discounts.percentage /100.00)), 0) as total_discount")
                      .group("invoice_items.id")
                      .sum(&:"total_discount")
    total_revenue_for_merchant(merchant) - a
    
  end

  
  def self.incomplete
    joins(:invoice_items).where.not(invoice_items: {status: 'shipped'}).order(:created_at).distinct
  end
end