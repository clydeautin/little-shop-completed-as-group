class Merchant < ApplicationRecord
  validates :name, presence: true

  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :items
  has_many :transactions, through: :items
  has_many :customers, through: :invoices

  def top_five_customers
    @transaction_ids = transactions.pluck(:id)

    self.customers.joins(:transactions)
      .where(transactions: {result: 'success', id: @transaction_ids})
      .group('customers.id')
      .order('count(transactions.id) desc')
      .limit(5)
  end

  #   customers.joins(:transactions).where("transactions.result = ? and customers.id = ?", "success", @customer_ids)
  #   # Customer.joins(invoices: :transactions).where(invoices: {customer_id: @ids}, transactions: {result: 'success'}).select("customers.*, transactions.id, invoices.customer_id")
  #   Customer.joins(invoices: :transactions).where(invoices: {customer_id: @customer_ids}, transactions: {result: 'success'}).distinct
  #   Customer.joins(invoices: :transactions).where(invoices: {customer_id: @customer_ids}, transactions: {result: 'success'}).select('customers.*, COUNT(transactions.id) AS transactions_count')

end