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

  def discounted_price
    discount = best_discount
    if discount
      unit_price - (unit_price * (discount.percentage / 100.0))
    else
      unit_price
    end
  end

  def discount?
    Discount.joins(:merchant)
            .where(merchants: { id: item.merchant.id })
            .where('threshold <= ?', quantity)
            .exists?
  end
end