FactoryBot.define do
  factory :invoice_item do
    quantity { rand(1..10) }
    unit_price { rand(100..10000) }
    status { rand(0..2) }
    association :item
    association :invoice
  end
end
