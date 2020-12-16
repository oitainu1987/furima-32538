FactoryBot.define do
  factory :item do
    item_name { 'test' }
    overview { 'この商品はtestです' }
    category_id { 2 }
    status_id { 2 }
    delivery_fee_id { 2 }
    area_id { 2 }
    period_id { 2 }
    price { 5000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
