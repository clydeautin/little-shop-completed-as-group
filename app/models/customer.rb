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
    @invoice_ids = transactions.pluck(:invoice_id)
    invoices.joins(invoice_items: :item)
            .joins(:transactions)
            .where(transactions: { result: 'success', invoice: @invoice_ids }, items: { merchant_id: @merchant_id })
            .count('transactions.id')
  end

  def successful_transactions
    transactions.count("transactions.result = 'success'")
  end
end