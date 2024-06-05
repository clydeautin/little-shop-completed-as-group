class Customer < ApplicationRecord
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :items, through: :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def successful_transactions_with_merchant(merchant)
    @merchant_id = merchant.id
    @transaction_ids = transactions.pluck(:id)
    transactions.joins(invoice: :items)
                .where(items: { merchant_id: @merchant_id }, id: @transaction_ids, result: 'success')
                .count
  end

  def successful_transactions
    transactions.where(transactions: {result: 'success'}).count
  end

  def self.top_five_customers
    Customer.joins(:transactions)
      .where(transactions: {result: 'success'})
      .group('customers.id')
      .order('count(transactions.id) desc')
      .limit(5)
  end
end