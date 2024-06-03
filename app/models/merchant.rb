class Merchant < ApplicationRecord
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
end