class Discount < ApplicationRecord
  
  validates :name, presence: true
  validates :percentage, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 100  }
  validates :threshold, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :merchant
end