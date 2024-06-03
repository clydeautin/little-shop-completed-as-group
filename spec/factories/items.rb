FactoryBot.define do
  factory :item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    unit_price { rand(100..10000) }
    association :merchant
    status { rand(0..1)}
  end
end
