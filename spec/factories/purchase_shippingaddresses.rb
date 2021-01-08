FactoryBot.define do
  factory :purchase_shippingaddress do
    postal_code {"123-4567"}
    prefecture_id {Faker::Number.within(range: 1..47)}
    city {Faker::Lorem.words(number: 4)}
    addresses {Faker::Lorem.words(number: 4)}
    building {Faker::Lorem.words(number: 4)}
    phone_number {"09011111111"}
    token {"tok_abcdefghijk00000000000000000"}
    user_id {1}
    item_id {1}
  end
end