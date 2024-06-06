class Discount < ApplicationRecord
  validates :name, presence: true
  validates :percentage, presence: true
  validates :threshold, presence: true

  belongs_to :merchant
end