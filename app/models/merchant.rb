class Merchant < ApplicationRecord
  enum status: {
    enabled: 0,
    disabled: 1
  }

  validates :name, presence: true

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items
  has_many :transactions, through: :items
  has_many :customers, through: :invoices

  def self.top_five_customers
    Customer.joins(:transactions)
      .where(transactions: {result: 'success'})
      .group('customers.id')
      .order('count(transactions.id) desc')
      .limit(5)
  end

  def top_five_customers
    @transaction_ids = transactions.pluck(:id)

    self.customers.joins(:transactions)
      .where(transactions: {result: 'success', id: @transaction_ids})
      .group('customers.id')
      .order('count(transactions.id) desc')
      .limit(5)
  end

  def items_ready_to_ship
    @merchant_invoice_ids = invoice_items.pluck(:id)

    Item.joins(invoices: :invoice_items)
      .where(invoice_items: {status: 1, id: @merchant_invoice_ids})
      .select('items.*, invoice_items.invoice_id, invoices.created_at as invoice_date')
      .order(:invoice_date)
      .distinct
  end

  def enabled_items
    items.where("items.status = 0")
  end

  def disabled_items
    items.where("items.status = 1")
  end

  def top_five_items
    items.joins(:transactions)
     .where(transactions: { result: 'success' })
     .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
     .group(:id)
     .order('total_revenue desc')
     .limit(5)
  end

  def self.enabled_merchants
    where("merchants.status = 0")
  end

  def self.disabled_merchants
    where("merchants.status = 1")
  end

  def self.top_five_merchants
    Merchant.joins(:transactions)
     .where(transactions: { result: 'success' })
     .select('merchants.*, sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue')
     .group(:id)
     .order('total_revenue desc')
     .limit(5)
  end

  def merchant_best_day
    invoice_items.joins(:transactions)
      .where("transactions.result = 'success'")
      .select('invoices.created_at, sum(invoice_items.quantity)')
      .group('invoices.created_at')
      .order('sum(invoice_items.quantity) desc')
      .limit(1)
      .pluck('invoices.created_at')[0]
  end
end