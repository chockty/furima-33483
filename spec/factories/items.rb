FactoryBot.define do
  factory :item do
    name {Faker::Name.name}
    info {Faker::Lorem.sentence}
    item_category_id {Faker::Number.within(range: 1..10)}
    item_sales_status_id {Faker::Number.within(range: 1..6)}
    item_shipping_id {Faker::Number.within(range: 1..2)}
    prefecture_id {Faker::Number.within(range: 1..47)}
    item_scheduled_delivery_id {Faker::Number.within(range: 1..3)}
    price {Faker::Number.within(range: 300..9999999)}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open("public/images/sample1.png"), filename: "sample1.png")
    end
  end
end
